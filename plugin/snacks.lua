require("snacks").setup({
    image = {
        enabled = true,
        force = true,
    },
    gh = {},
    lazygit = {
        enabled = false,
    },
    explorer = {
        enabled = false,
    },
    picker = {
        enabled = true,
        previewers = {
            diff = {
                cmd = { "delta" },
            },
        },
        formatters = {
            file = {
                filename_first = true,
                truncate = 40,
            },
        },
    },
    bigfile = { enabled = true },
    scroll = {
        animate = {
            duration = {
                step = 10,
                total = 50,
            },
            easing = "linear",
        },
    },
    input = { enabled = true },
    zen = {
        toggles = {
            dim = false,
            git_signs = true,
            diagnostics = true,
            inlay_hints = true,
        },
        show = {
            statusline = false,
            tabline = false,
        },
        zoom = {
            toggles = {},
            show = { statusline = true, tabline = true },
            win = {
                backdrop = false,
                width = 0, -- full width
            },
        },
    },
    terminal = {
        enabled = true,
        keys = {
            q = "hide",
            gf = function(self)
                local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
                if f == "" then
                    Snacks.notify.warn("No file under cursor")
                else
                    self:hide()
                    vim.schedule(function()
                        vim.cmd("e " .. f)
                    end)
                end
            end,
        },
    },
    scope = {
        enabled = true,
    },
    indent = {
        animate = {
            enabled = vim.fn.has("nvim-0.10") == 1,
            easing = "linear",
            duration = {
                step = 20, -- ms per step
                total = 100, -- maximum duration
            },
        },
        scope = {
            enabled = true,
            underline = false,
        },
        chunk = {
            -- when enabled, scopes will be rendered as chunks, except for the
            -- top-level scope which will be rendered as a scope.
            enabled = true,
            -- only show chunk scopes in the current window
            only_current = true,
            hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
            char = {
                corner_top = "┌",
                corner_bottom = "└",
                horizontal = "─",
                vertical = "│",
                arrow = ">",
            },
        },
        -- filter for buffers to enable indent guides
        filter = function(buf)
            return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
    },
    dashboard = {
        enabled = false,
    },
    notifier = {
        enabled = true,
        timeout = 3000,
        max_notifications = 4,
    },
    quickfile = { enabled = true },
    bufdelete = { enabled = true },
    statuscolumn = {
        enabled = true,
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
            open = true, -- show open fold icons
            git_hl = true, -- use Git Signs hl for fold icons
        },
        git = {
            -- patterns to match Git signs
            patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50, -- refresh at most every 50ms
    },
    words = { enabled = true },
})

local key = vim.keymap.set

key("n", "<leader>Gi", function()
    Snacks.picker.gh_issue()
end, { desc = "GitHub Issues (open)" })
key("n", "<leader>GI", function()
    Snacks.picker.gh_issue({ state = "all" })
end, { desc = "GitHub Issues (all)" })
key("n", "<leader>Gq", function()
    Snacks.picker.gh_pr()
end, { desc = "GitHub Pull Requests (open)" })
key("n", "<leader>GQ", function()
    Snacks.picker.gh_pr({ state = "all" })
end, { desc = "GitHub Pull Requests (all)" })
key("n", "<leader>/", function()
    Snacks.picker.grep()
end, { desc = "Grep" })
key("n", "<leader>:", function()
    Snacks.picker.command_history()
end, { desc = "Command History" })
key("n", "<leader>,", function()
    Snacks.picker.buffers()
end, { desc = "Buffers" })
key("n", "<leader><space>", function()
    Snacks.picker.smart()
end, { desc = "Smart Find Files" })
key("n", "<leader>fn", function()
    Snacks.picker.notifications()
end, { desc = "Notify" })
-- find
key("n", "<leader>fb", function()
    Snacks.picker.buffers()
end, { desc = "Buffers" })
key("n", "<leader>fh", function()
    Snacks.picker.files({ cwd = vim.fn.expand("$HOME") })
end, { desc = "Find home File" })
key("n", "<leader>fc", function()
    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Config File" })
key("n", "<leader>ff", function()
    Snacks.picker.files()
end, { desc = "Find Files" })
key("n", "<leader>fg", function()
    Snacks.picker.git_files()
end, { desc = "Find Git Files" })
key("n", "<leader>fr", function()
    Snacks.picker.recent()
end, { desc = "Recent" })
-- git
key("n", "<leader>gA", function()
    Snacks.picker.git_log()
end, { desc = "Log" })
key("n", "<leader>ga", function()
    Snacks.picker.git_branches()
end, { desc = "Branches" })
key("n", "<leader>gL", function()
    Snacks.picker.git_log_line()
end, { desc = "Log Line" })
-- Grep
key("n", "<leader>sb", function()
    Snacks.picker.lines()
end, { desc = "Buffer Lines" })
key("n", "<leader>sB", function()
    Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })
key("n", "<leader>sD", function()
    Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })
key("n", "<leader>sg", function()
    Snacks.picker.grep()
end, { desc = "Grep" })
key("n", "<leader>fs", function()
    Snacks.picker.grep()
end, { desc = "Grep" })
key({ "n", "x" }, "<leader>sw", function()
    Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })
key("x", "<leader>sg", function()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])
    if #lines == 0 then
        return
    end
    lines[1] = string.sub(lines[1], start_pos[3])
    if #lines == 1 then
        lines[1] = string.sub(lines[1], 1, end_pos[3] - start_pos[3] + 1)
    else
        lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    end
    local selection = table.concat(lines, "\n")
    Snacks.picker.grep({ search = selection })
end, { desc = "Grep in visual selection" })
-- search
key("n", '<leader>s"', function()
    Snacks.picker.registers()
end, { desc = "Registers" })
key("n", "<leader>sa", function()
    Snacks.picker.autocmds()
end, { desc = "Autocmds" })
key("n", "<leader>sc", function()
    Snacks.picker.command_history()
end, { desc = "Command History" })
key("n", "<leader>sC", function()
    Snacks.picker.commands()
end, { desc = "Commands" })
key("n", "<leader>sd", function()
    Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
key("n", "<leader>sh", function()
    Snacks.picker.help()
end, { desc = "Help Pages" })
key("n", "<leader>sH", function()
    Snacks.picker.highlights()
end, { desc = "Highlights" })
key("n", "<leader>sj", function()
    Snacks.picker.jumps()
end, { desc = "Jumps" })
key("n", "<leader>sk", function()
    Snacks.picker.keymaps()
end, { desc = "Keymaps" })
key("n", "<leader>sl", function()
    Snacks.picker.loclist()
end, { desc = "Location List" })
key("n", "<leader>sM", function()
    Snacks.picker.man()
end, { desc = "Man Pages" })
key("n", "<leader>sm", function()
    Snacks.picker.marks()
end, { desc = "Marks" })
key("n", "<leader>sr", function()
    Snacks.picker.resume()
end, { desc = "Resume" })
key("n", "<leader>su", function()
    Snacks.picker.undo()
end, { desc = "Undo History" })
key("n", "<leader>sq", function()
    Snacks.picker.qflist()
end, { desc = "Quickfix List" })
key("n", "<leader>st", function()
    Snacks.picker.todo_comments()
end, { desc = "Todo" })
key("n", "<leader>sT", function()
    Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
end, { desc = "Todo/Fix/Fixme" })
key("n", "<leader>fC", function()
    Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })
-- LSP
key("n", "gd", function()
    Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
key("n", "grr", function()
    Snacks.picker.lsp_references()
end, {
    desc = "References",
    nowait = true,
})
key("n", "gri", function()
    Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })
key("n", "gy", function()
    Snacks.picker.lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })
key("n", "gO", function()
    Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })
key("n", "<leader>ss", function()
    Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })
key("n", "<leader>fl", function()
    Snacks.picker.lsp_config()
end, { desc = "Lsp Info" })
key("n", "<leader>EE", function()
    Snacks.explorer.open()
end, { desc = "Explorer" })
key("n", "<leader>un", function()
    Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })
key("n", "<leader>q", function()
    Snacks.bufdelete()
end, { desc = "Delete Buffer" })
key("n", "<leader>gg", function()
    Snacks.lazygit()
end, { desc = "Lazygit" })
key("n", "<leader>gG", function()
    require("snacks").terminal("lazygit --git-dir=$HOME/.cfg --work-tree=$HOME")
end, { desc = "Lazygit dotfiles" })
key("n", "<leader>gB", function()
    Snacks.gitbrowse()
end, { desc = "Browse repo" })
key("n", "<leader>gf", function()
    Snacks.lazygit.log_file()
end, { desc = "Lazygit Current File History" })
key("n", "<leader>gl", function()
    Snacks.lazygit.log()
end, { desc = "Lazygit Log (cwd)" })
key("n", "grf", function()
    Snacks.rename.rename_file()
end, { desc = "Rename File" })
-- Git conflict resolution
key("n", "<leader>gx", function()
    vim.fn.search("^<<<<<<< ", "w")
end, { desc = "Next git conflict" })
key("n", "<leader>gX", function()
    vim.fn.search("^<<<<<<< ", "bw")
end, { desc = "Previous git conflict" })
key("n", "<leader>gh", function()
    local start_line = vim.fn.search("^<<<<<<< ", "bcnW")
    if start_line == 0 then
        vim.notify("No conflict marker found", vim.log.levels.WARN)
        return
    end
    local mid_line = vim.fn.search("^=======$", "nW")
    local end_line = vim.fn.search("^>>>>>>> ", "nW")
    if mid_line == 0 or end_line == 0 then
        vim.notify("Incomplete conflict marker", vim.log.levels.ERROR)
        return
    end
    -- Find base marker (zdiff3/diff3) between start and mid
    local base_line = 0
    for i = start_line + 1, mid_line - 1 do
        if vim.fn.getline(i):match("^||||||| ") then
            base_line = i
            break
        end
    end
    -- Delete from base marker (or mid if no base) to end
    local delete_from = base_line > 0 and base_line or mid_line
    vim.cmd(string.format("%d,%dd", delete_from, end_line))
    vim.cmd(string.format("%dd", start_line))
    vim.notify("Kept ours (HEAD)", vim.log.levels.INFO)
end, { desc = "Conflict: Keep ours (HEAD)" })
key("n", "<leader>gt", function()
    local start_line = vim.fn.search("^<<<<<<< ", "bcnW")
    if start_line == 0 then
        vim.notify("No conflict marker found", vim.log.levels.WARN)
        return
    end
    local mid_line = vim.fn.search("^=======$", "nW")
    local end_line = vim.fn.search("^>>>>>>> ", "nW")
    if mid_line == 0 or end_line == 0 then
        vim.notify("Incomplete conflict marker", vim.log.levels.ERROR)
        return
    end
    vim.cmd(string.format("%d,%dd", start_line, mid_line))
    vim.cmd(string.format("%dd", end_line - (mid_line - start_line + 1)))
    vim.notify("Kept theirs", vim.log.levels.INFO)
end, { desc = "Keep theirs" })
key("n", "<leader>gC", function()
    local conflicts = {}
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for i, line in ipairs(lines) do
        if line:match("^<<<<<<< ") then
            table.insert(conflicts, { bufnr = bufnr, lnum = i, text = line })
        end
    end
    if #conflicts == 0 then
        vim.notify("No conflicts found in buffer", vim.log.levels.INFO)
        return
    end
    vim.fn.setqflist(conflicts, "r")
    vim.cmd("copen")
    vim.notify(string.format("Found %d conflict(s)", #conflicts), vim.log.levels.INFO)
end, { desc = "List git conflicts in buffer" })
key("n", "<leader>tf", function()
    Snacks.terminal(nil, { win = { position = "float" } })
end, { desc = "Toggle Terminal (float)" })
key("n", "<leader>ts", function()
    Snacks.terminal(nil, { win = { position = "bottom", height = 10 } })
end, { desc = "Toggle Terminal (bottom)" })
key("n", "<leader>tv", function()
    Snacks.terminal(nil, { win = { position = "right", width = 90 } })
end, { desc = "Toggle Terminal (right)" })
key("n", "<leader>tt", function()
    Snacks.terminal()
end, { desc = "Toggle Terminal" })
key("n", "<leader>tc", function()
    Snacks.terminal(vim.fn.input("Run command", "", "shellcmdline"), { auto_close = false })
end, { desc = "Run command in terminal" })
key("n", "<leader>tC", function()
    Snacks.terminal(vim.fn.input("Run command", "", "shellcmdline"), { auto_close = true })
end, { desc = "Run command in terminal (autoclose)" })

-- Task runner commands
key("n", "<leader>tb", function()
    Snacks.terminal("make build", { auto_close = false })
end, { desc = "Build project" })
key("n", "<leader>tT", function()
    Snacks.terminal("make test", { auto_close = false })
end, { desc = "Run tests" })
key("n", "<leader>tr", function()
    Snacks.terminal("make run", { auto_close = false })
end, { desc = "Run project" })
key("n", "<leader>tl", function()
    Snacks.terminal("make lint", { auto_close = false })
end, { desc = "Lint project" })

key("n", "<c-_>", function()
    Snacks.terminal()
end, { desc = "which_key_ignore" })
key("n", "]]", function()
    Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
key("n", "[[", function()
    Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })
key("n", "<leader>NE", function()
    Snacks.win({
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
        width = 0.6,
        height = 0.6,
        wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
        },
    })
end, { desc = "Neovim News" })

local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesActionRename",
    callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
})
-- Setup some globals for debugging (lazy-loaded)
_G.dd = function(...)
    Snacks.debug.inspect(...)
end
_G.bt = function()
    Snacks.debug.backtrace()
end
vim.print = _G.dd -- Override print to use snacks for `:=` command

-- Create some toggle mappings
Snacks.toggle.zen():map("<leader>uz")
Snacks.toggle.zoom():map("<leader>uZ")
Snacks.toggle.zen():map("<leader>z")
Snacks.toggle.zoom():map("<leader>Z")
Snacks.toggle.indent():map("<leader>ui")
Snacks.toggle.words():map("<leader>uW")
Snacks.toggle.scroll():map("<leader>uS")
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
    :map("<leader>uc")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle({
    name = "Auto Format global",
    get = function()
        return vim.g.autoformat
    end,
    set = function(state)
        vim.g.autoformat = state
    end,
}):map("<leader>uf")
Snacks.toggle({
    name = "Auto Format buffer",
    get = function()
        return vim.b.autoformat
    end,
    set = function(state)
        vim.b.autoformat = state
    end,
}):map("<leader>uF")
