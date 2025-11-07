local Init = require("ado")
local CommentCtx = require("ado.comment_context")
local Api = {}

local function normalize_repo_path(path, repo_root)
    if not path or path == "" then
        return nil
    end
    return CommentCtx.to_repo_relative(path, repo_root)
end

local function build_pr_thread_context(pr_id, file_path)
    local last_iter = Api.get_latest_iteration(pr_id)
    local change_id = Api.get_change_tracking_id(pr_id, file_path, last_iter)
    return {
        changeTrackingId = change_id,
        iterationContext = {
            firstComparingIteration = math.max(1, (last_iter or 1) - 1),
            secondComparingIteration = last_iter or 1,
        },
    }
end

local function has_vim_system()
    return vim.system ~= nil
end

local function basic_auth_header()
    local pat = Init.cfg.pat or vim.env[Init.cfg.pat_env or "AZURE_DEVOPS_PAT"]
    if not pat or pat == "" then
        error("azure-devops.nvim: Missing PAT. Set `pat` in setup() or the env var.")
    end
    local token = vim.base64.encode(":" .. pat)
    return "Authorization: Basic " .. token
end

local function base_url()
    return string.format("https://dev.azure.com/%s/%s/_apis", Init.cfg.org, Init.cfg.project)
end

local function curl_json(url, method, body_tbl)
    local headers =
        { basic_auth_header(), "Content-Type: application/json", "Accept: application/json" }
    local args = {
        "curl",
        "-sS",
        "-X",
        method or "GET",
        url,
        "-H",
        headers[1],
        "-H",
        headers[2],
        "-H",
        headers[3],
    }
    if body_tbl then
        local payload = vim.json.encode(body_tbl)
        table.insert(args, "--data")
        table.insert(args, payload)
    end

    local result
    if has_vim_system() then
        result = vim.system(args, { text = true }):wait()
    else
        local job = vim.fn.jobstart(args, { stdout_buffered = true, stderr_buffered = true })
        vim.fn.jobwait({ job })
        local stdout = table.concat(vim.fn.jobgetoutput(job), " ")
        result = { code = 0, stdout = stdout, stderr = "" }
    end

    if result.code ~= 0 then
        error("azure-devops.nvim: curl failed: " .. (result.stderr or ""))
    end

    local ok, parsed = pcall(vim.json.decode, result.stdout)
    if not ok then
        error("azure-devops.nvim: failed to parse JSON from ADO")
    end
    return parsed
end

-- latest PR iteration id
function Api.get_latest_iteration(pr_id)
    local url = string.format(
        "%s/git/repositories/%s/pullRequests/%s/iterations?api-version=7.1",
        base_url(),
        Api.ensure_repo_id(),
        pr_id
    )
    local data = curl_json(url, "GET")
    assert(data and data.value and #data.value > 0, "No iterations for PR")
    return data.value[#data.value].id
end

-- changeTrackingId for a specific file in the latest iteration (needed for ranges)
function Api.get_change_tracking_id(pr_id, file_path, iteration_id)
    file_path = normalize_repo_path(file_path)
    if not file_path then
        return nil
    end
    local url = string.format(
        "%s/git/repositories/%s/pullRequests/%s/iterations/%d/changes?api-version=7.1",
        base_url(),
        Api.ensure_repo_id(),
        pr_id,
        iteration_id
    )
    local data = curl_json(url, "GET")
    for _, ch in ipairs(data and data.changeEntries or {}) do
        local it = ch and ch.item
        local candidate = it and it.path and normalize_repo_path(it.path)
        if candidate == file_path and ch.changeTrackingId then
            return ch.changeTrackingId
        end
    end
    -- Fallback: some diffs put the path on changeEntries.[].originalPath/newPath
    for _, ch in ipairs(data and data.changeEntries or {}) do
        local orig = ch.originalPath and normalize_repo_path(ch.originalPath)
        local newp = ch.newPath and normalize_repo_path(ch.newPath)
        if
            ((orig and orig == file_path) or (newp and newp == file_path)) and ch.changeTrackingId
        then
            return ch.changeTrackingId
        end
    end
    return nil
end

-- absolute-url variant
local function curl_json_abs(url, method, body_tbl)
    return curl_json(url, method, body_tbl)
end

-- Resolve and cache repository id
function Api.ensure_repo_id()
    if Init._repo_id then
        return Init._repo_id
    end
    local url = string.format("%s/git/repositories?api-version=7.1-preview.1", base_url())
    local res = curl_json(url, "GET")
    for _, r in ipairs(res.value or {}) do
        if r.name == Init.cfg.repo then
            Init._repo_id = r.id
            return Init._repo_id
        end
    end
    error("azure-devops.nvim: repository not found: " .. tostring(Init.cfg.repo))
end

-- PRs
function Api.list_prs(state)
    state = state or "active"
    local repo_id = Api.ensure_repo_id()
    local url = string.format(
        "%s/git/pullrequests?searchCriteria.repositoryId=%s&searchCriteria.status=%s&api-version=7.1-preview.1",
        base_url(),
        repo_id,
        state
    )
    return curl_json(url, "GET")
end

function Api.find_pr_by_branch(branch)
    local repo_id = Api.ensure_repo_id()
    local ref = string.format("refs/heads/%s", branch)
    local url = string.format(
        "%s/git/pullrequests?searchCriteria.repositoryId=%s&searchCriteria.sourceRefName=%s&searchCriteria.status=all&api-version=7.1-preview.1",
        base_url(),
        repo_id,
        vim.fn.escape(ref, " ")
    )
    local res = curl_json(url, "GET")
    local candidate
    for _, pr in ipairs(res.value or {}) do
        if pr.status == "active" then
            return pr
        end
        candidate = candidate or pr
    end
    return candidate
end

-- Pipelines
function Api.list_pipelines()
    local url = string.format("%s/pipelines?api-version=7.1-preview.1", base_url())
    return curl_json(url, "GET")
end

function Api.run_pipeline(pipeline_id, branch)
    local url =
        string.format("%s/pipelines/%s/runs?api-version=7.1-preview.1", base_url(), pipeline_id)
    local body = {
        resources = {
            repositories = {
                self = {
                    refName = string.format("refs/heads/%s", branch or Init.cfg.default_branch),
                },
            },
        },
    }
    return curl_json(url, "POST", body)
end

-- Builds
function Api.list_builds(top)
    local url = string.format(
        "%s/build/builds?api-version=7.1-preview.7%s",
        base_url(),
        top and ("&$top=" .. top) or ""
    )
    return curl_json(url, "GET")
end

-- PR Threads & Comments
function Api.list_pr_threads(pr_id)
    local repo_id = Api.ensure_repo_id()
    local url = string.format(
        "%s/git/repositories/%s/pullRequests/%s/threads?api-version=7.1-preview.1",
        base_url(),
        repo_id,
        pr_id
    )
    return curl_json(url, "GET")
end

function Api.create_pr_selection_comment(pr_id, file_path, sline, scol, eline, ecol, text, opts)
    local repo_id = Api.ensure_repo_id()
    opts = opts or {}
    file_path = normalize_repo_path(file_path)
    -- Normalize positions
    if eline < sline or (eline == sline and ecol < scol) then
        sline, eline, scol, ecol = eline, sline, ecol, scol
    end
    scol = math.max(0, (scol or 1) - 1) -- offset must be 0-based
    ecol = math.max(0, (ecol or 1) - 1)

    local url = string.format(
        "%s/git/repositories/%s/pullRequests/%s/threads?api-version=7.1",
        base_url(),
        repo_id,
        pr_id
    )

    local thread_ctx =
        CommentCtx.build_thread_context(file_path, sline, scol, eline, ecol, opts.side)
    local pr_thread_ctx = build_pr_thread_context(pr_id, file_path)
    local body = {
        comments = { { content = text, commentType = "text" } },
        status = "active",
        threadContext = thread_ctx,
    }
    if pr_thread_ctx then
        body.pullRequestThreadContext = pr_thread_ctx
    end

    return curl_json(url, "POST", body)
end

function Api.create_pr_line_comment(pr_id, file_path, line, text, opts)
    local repo_id = Api.ensure_repo_id()
    opts = opts or {}
    file_path = normalize_repo_path(file_path)
    local url = string.format(
        "%s/git/repositories/%s/pullRequests/%s/threads?api-version=7.1-preview.1",
        base_url(),
        repo_id,
        pr_id
    )
    local thread_ctx = CommentCtx.build_thread_context(file_path, line, 0, line, 0, opts.side)
    local pr_thread_ctx = build_pr_thread_context(pr_id, file_path)
    local body = {
        comments = { { content = text, commentType = "text" } },
        status = "active",
        threadContext = thread_ctx,
    }
    if pr_thread_ctx then
        body.pullRequestThreadContext = pr_thread_ctx
    end
    return curl_json(url, "POST", body)
end

function Api.update_thread_status(pr_id, thread_id, status)
    local repo_id = Api.ensure_repo_id()
    local url = string.format(
        "%s/git/repositories/%s/pullRequests/%s/threads/%s?api-version=7.1-preview.1",
        base_url(),
        repo_id,
        pr_id,
        thread_id
    )
    local body = { status = status }
    return curl_json(url, "PATCH", body)
end

-- Add a reply comment to an existing thread
function Api.reply_pr_thread(pr_id, thread_id, text)
    local repo_id = Api.ensure_repo_id()
    local url = string.format(
        "%s/git/repositories/%s/pullRequests/%s/threads/%s/comments?api-version=7.1-preview.1",
        base_url(),
        repo_id,
        pr_id,
        thread_id
    )
    local body = { content = text, commentType = "text" }
    return curl_json(url, "POST", body)
end

function Api.update_pr_comment(pr_id, thread_id, comment_id, text)
    local repo_id = Api.ensure_repo_id()
    local url = string.format(
        "%s/git/repositories/%s/pullRequests/%s/threads/%s/comments/%s?api-version=7.1-preview.1",
        base_url(),
        repo_id,
        pr_id,
        thread_id,
        comment_id
    )
    local body = { content = text, commentType = "text" }
    return curl_json(url, "PATCH", body)
end

-- Reviewer vote: -10 reject, -5 waiting for author, 0 no vote, 5 approve with suggestions, 10 approve
local function get_me_descriptor()
    -- Use vssps.dev.azure.com/{org} which reliably returns JSON for profile me
    local org = require("ado").cfg.org or ""
    local url = string.format(
        "https://vssps.dev.azure.com/%s/_apis/profile/profiles/me?api-version=7.1-preview.3",
        org
    )
    local res = curl_json_abs(url, "GET")
    return res.id
        or (
            res.coreAttributes
            and res.coreAttributes.PublicAlias
            and res.coreAttributes.PublicAlias.value
        )
end

function Api.set_vote(pr_id, vote)
    local me = get_me_descriptor()
    if not me then
        error("could not resolve current user id for voting")
    end
    local repo_id = Api.ensure_repo_id()
    local url = string.format(
        "%s/git/repositories/%s/pullRequests/%s/reviewers/%s?api-version=7.1-preview.1",
        base_url(),
        repo_id,
        pr_id,
        me
    )
    local body = { vote = vote }
    local ok, res = pcall(curl_json, url, "PUT", body)
    if not ok then
        error(res)
    end
    return res
end

-- Utilities to construct web URLs for opening in browser
function Api.web_urls()
    return {
        org = Init.cfg.org,
        project = Init.cfg.project,
        repo = Init.cfg.repo,
        base = string.format("https://dev.azure.com/%s/%s", Init.cfg.org, Init.cfg.project),
    }
end

return Api
