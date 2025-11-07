--[=[
azure-devops.nvim — a lightweight Azure DevOps companion for Neovim

Snacks-first 🎒 pickers via `vim.ui.select` (Snacks decorates automatically). Falls back to Telescope or a builtin floating list.

New in this cut
- Auto-detect `org`/`project`/`repo` from your Git remote (origin/upstream)
- Detect PR from your **current branch**
- Comment on PR at your **current file/line**; if a **Visual** selection exists, its text becomes the comment body
- PR interactions: list threads, add line comments, resolve/reopen threads, and set your review vote

Auth: Personal Access Token (PAT)
- Set env var AZURE_DEVOPS_PAT (scopes: Build (Read & Execute), Code (Read), Work Items (Read), Pipelines (Read & Execute))
- Or pass `pat` to setup(). PAT used via basic auth.

Config example (init.lua):

  require("ado").setup({
    -- org = "my-org",        -- optional: will be auto-detected from git remote if omitted
    -- project = "my-project", -- optional: auto
    -- repo = "my-repo",       -- optional: auto
    pat_env = "AZURE_DEVOPS_PAT",
    picker = "auto",               -- "auto" | "snacks" | "telescope" | "builtin"
    default_branch = "main",
  })

Commands provided:
  :AdoPRs                 — list PRs for the repo
  :AdoPipelines           — list pipelines
  :AdoBuilds              — list recent builds
  :AdoRunPipeline         — pick a pipeline and branch, then run
  :AdoBrowse              — open smart ADO page for current branch/commit

PR commands:
  :AdoPRThreads [id]      — list PR threads; defaults to PR for the **current branch**
  :AdoPRComment  [id] [side] [suggestion] — capture current file/line or Visual selection, open an editable buffer with
                               context, and submit (or update) the comment on write (:w). Pass `left/right` to target
                               diff sides and `suggestion` to prefill a ```suggestion block.
  :AdoPREditComment [id] <thread> [comment] — open an existing comment for editing; saving updates it in-place.
  :AdoPRResolve  [id]     — pick a thread and resolve/close it
  :AdoPRReopen   [id]     — pick a thread and reopen/active it
  :AdoPRVote     [id]     — set your vote (Approve/Approve w/ Suggestions/Wait for Author/Reject)
  :AdoDetect              — show inferred org/project/repo from git
]=]

local M = {}

local defaults = {
    org = nil,
    project = nil,
    repo = nil,
    pat = nil, -- if nil, read from env `pat_env`
    pat_env = "AZURE_DEVOPS_PAT",
    picker = "auto", -- "auto" | "snacks" | "telescope" | "builtin"
    default_branch = "main",
}

M.cfg = vim.deepcopy(defaults)
M._repo_id = nil -- cache repository id (GUID)

local function read_cmd(cmd)
    local lines = vim.fn.systemlist(cmd)
    if vim.v.shell_error ~= 0 then
        return nil
    end
    return (lines and lines[1]) or nil
end

local function parse_remote(url)
    if not url or url == "" then
        return nil
    end
    -- Supported forms:
    -- https://dev.azure.com/org/project/_git/repo
    -- https://org@dev.azure.com/org/project/_git/repo
    -- https://org.visualstudio.com/project/_git/repo
    -- ssh: git@ssh.dev.azure.com:v3/org/project/repo
    -- ssh old: org@vs-ssh.visualstudio.com:v3/org/project/repo
    local org, project, repo
    org, project, repo = url:match("https://dev%.azure%.com/([^/]+)/([^/]+)/_git/([^/?#]+)")
    if not org then
        org, project, repo =
            url:match("https://[^@]+@dev%.azure%.com/([^/]+)/([^/]+)/_git/([^/?#]+)")
    end
    if not org then
        local sub
        sub, project, repo = url:match("https://([^.]+)%.visualstudio%.com/([^/]+)/_git/([^/?#]+)")
        if sub then
            org = sub
        end
    end
    if not org then
        org, project, repo = url:match("git@ssh%.dev%.azure%.com:v3/([^/]+)/([^/]+)/([^/?#]+)")
    end
    if not org then
        org, project, repo =
            url:match("[^@]+@vs%-ssh%.visualstudio%.com:v3/([^/]+)/([^/]+)/([^/?#]+)")
    end
    if org and project and repo then
        return { org = org, project = project, repo = repo }
    end
    return nil
end

local function autodetect()
    local remotes = {
        read_cmd({ "git", "remote", "get-url", "origin" }),
        read_cmd({ "git", "remote", "get-url", "upstream" }),
    }
    for _, u in ipairs(remotes) do
        local p = parse_remote(u)
        if p then
            return p
        end
    end
    return nil
end

function M.setup(opts)
    M.cfg = vim.tbl_deep_extend("force", defaults, opts or {})
    if not (M.cfg.org and M.cfg.project and M.cfg.repo) then
        local p = autodetect()
        if p then
            M.cfg.org = M.cfg.org or p.org
            M.cfg.project = M.cfg.project or p.project
            M.cfg.repo = M.cfg.repo or p.repo
            vim.notify(
                string.format(
                    "azure-devops.nvim: auto-detected %s/%s/%s",
                    M.cfg.org,
                    M.cfg.project,
                    M.cfg.repo
                )
            )
        else
            vim.notify(
                "azure-devops.nvim: could not auto-detect org/project/repo from git remote",
                vim.log.levels.WARN
            )
        end
    end
end

return M
