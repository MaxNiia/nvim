-- Azure DevOps Neovim Plugin: user commands
-- Safer arg parsing, proper -range where needed, and friendlier errors

require("ado").setup({})

local ui = require("ado.ui")

-- Small helper: pcall UI calls and surface errors nicely
local function safe_call(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then
        vim.notify("Azure DevOps: " .. tostring(err), vim.log.levels.ERROR)
    end
end

local function to_num(s)
    if s == nil or s == "" then
        return nil
    end
    return tonumber(s)
end

local function parse_comment_args(argstr)
    local pr_id, side, suggestion
    for _, token in ipairs(vim.split(argstr or "", " ", { trimempty = true })) do
        local maybe = tonumber(token)
        if maybe and not pr_id then
            pr_id = maybe
        else
            local lower = token:lower()
            if (lower == "left" or lower == "right") and not side then
                side = lower
            elseif lower == "suggest" or lower == "suggestion" then
                suggestion = true
            end
        end
    end
    return pr_id, side, suggestion
end

local function parse_edit_comment_args(argstr)
    local nums = {}
    for _, token in ipairs(vim.split(argstr or "", " ", { trimempty = true })) do
        local maybe = tonumber(token)
        if maybe then
            nums[#nums + 1] = maybe
        end
    end
    local pr_id, thread_id, comment_id
    if #nums == 1 then
        thread_id = nums[1]
    elseif #nums == 2 then
        pr_id, thread_id = nums[1], nums[2]
    elseif #nums >= 3 then
        pr_id, thread_id, comment_id = nums[1], nums[2], nums[3]
    end
    return pr_id, thread_id, comment_id
end

-- Top-level pickers
vim.api.nvim_create_user_command("AdoPRs", function()
    safe_call(ui.pick_prs, "active")
end, { desc = "Pick active PRs" })

vim.api.nvim_create_user_command("AdoPipelines", function()
    safe_call(ui.pick_pipelines)
end, { desc = "Pick pipelines" })

vim.api.nvim_create_user_command("AdoBuilds", function()
    safe_call(ui.pick_builds)
end, { desc = "Pick builds" })

vim.api.nvim_create_user_command("AdoRunPipeline", function()
    -- Keep behavior consistent with original; UI decides what to do
    safe_call(ui.pick_pipelines)
end, { desc = "Run a pipeline" })

vim.api.nvim_create_user_command("AdoBrowse", function()
    safe_call(ui.browse_smart)
end, { desc = "Open current item in browser" })

-- Auto-detect info
vim.api.nvim_create_user_command("AdoDetect", function()
    safe_call(ui.show_detect)
end, { desc = "Show auto-detected org/project/repo" })

-- PR interactions
vim.api.nvim_create_user_command("AdoPRThreads", function(opts)
    local id = to_num(opts.args)
    safe_call(require("ado.ui").pr_threads, id, "all")
end, { nargs = "?", desc = "List PR threads (all)" })

vim.api.nvim_create_user_command("AdoPRThreadsActive", function(opts)
    local id = to_num(opts.args)
    safe_call(require("ado.ui").pr_threads, id, "active")
end, { nargs = "?", desc = "List PR threads (active)" })

vim.api.nvim_create_user_command("AdoPRThreadsUnresolved", function(opts)
    local id = to_num(opts.args)
    safe_call(require("ado.ui").pr_threads, id, "unresolved")
end, { nargs = "?", desc = "List PR threads (unresolved)" })

vim.api.nvim_create_user_command("AdoPRComment", function(opts)
    local id, side, suggestion = parse_comment_args(opts.args)
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local selection
    if opts.range ~= 0 then
        local s = vim.fn.getpos("'<")
        local e = vim.fn.getpos("'>")
        if s[2] ~= 0 and e[2] ~= 0 then
            selection = {
                sline = s[2],
                scol = s[3],
                eline = e[2],
                ecol = e[3],
            }
        end
    end
    safe_call(require("ado.ui").pr_comment, id, {
        side = side,
        bufnr = bufnr,
        selection = selection,
        cursor_line = cursor_line,
        suggestion = suggestion,
    })
end, {
    nargs = "*",
    range = true,
    desc = "Open an editable buffer for a PR comment (optional <pr_id>, left/right, suggestion)",
    complete = function()
        return { "left", "right", "suggestion" }
    end,
})

vim.api.nvim_create_user_command("AdoPRResolve", function(opts)
    local id = to_num(opts.args)
    safe_call(require("ado.ui").pr_resolve, id, "closed")
end, { nargs = "?", desc = "Resolve PR thread (closed)" })

vim.api.nvim_create_user_command("AdoPRReopen", function(opts)
    local id = to_num(opts.args)
    safe_call(require("ado.ui").pr_resolve, id, "active")
end, { nargs = "?", desc = "Reopen PR thread (active)" })

vim.api.nvim_create_user_command("AdoPREditComment", function(opts)
    local pr_id, thread_id, comment_id = parse_edit_comment_args(opts.args)
    if not thread_id then
        vim.notify("Usage: :AdoPREditComment [pr_id] <thread_id> [comment_id]", vim.log.levels.WARN)
        return
    end
    safe_call(require("ado.ui").pr_edit_comment, pr_id, thread_id, comment_id)
end, {
    nargs = "+",
    desc = "Edit an existing PR comment",
})

-- Voting: no args -> UI prompts; one numeric arg -> PR id; two args could be added later
vim.api.nvim_create_user_command("AdoPRVote", function(opts)
    local id = to_num(opts.args)
    safe_call(require("ado.ui").pr_vote, id)
end, { nargs = "?", desc = "Vote on the current (or given) PR" })

-- Show a specific thread; supports either `<thread_id>` or `[pr_id] <thread_id>`
vim.api.nvim_create_user_command("AdoPRShowThread", function(opts)
    local args = vim.split(opts.args or "", " ", { plain = true, trimempty = true })
    local pr_id, thread_id
    if #args == 1 then
        thread_id = to_num(args[1])
    elseif #args >= 2 then
        pr_id = to_num(args[1])
        thread_id = to_num(args[2])
    end

    if thread_id then
        safe_call(require("ado.ui").pr_show_thread, pr_id, thread_id)
    else
        vim.notify("Usage: :AdoPRShowThread [pr_id] <thread_id>", vim.log.levels.WARN)
    end
end, {
    nargs = "+",
    complete = function()
        return {}
    end,
    desc = "Open a PR comment thread",
})

vim.keymap.set("n", "<leader>gt", function()
    vim.cmd("AdoPRThreads")
end, { desc = "Azure DevOps Threads" })

vim.keymap.set("n", "<leader>gc", function()
    vim.cmd("AdoPRComment")
end, { desc = "Azure DevOps Comment" })

vim.keymap.set("v", "<leader>gc", function()
    vim.cmd("'<,'>AdoPRComment")
end, { desc = "Azure DevOps Comment Selection" })

vim.keymap.set("n", "<leader>gC", function()
    vim.cmd("AdoPRComment suggestion")
end, { desc = "Azure DevOps Suggestion" })

vim.keymap.set("v", "<leader>gC", function()
    vim.cmd("'<,'>AdoPRComment suggestion")
end, { desc = "Azure DevOps Suggestion Selection" })
