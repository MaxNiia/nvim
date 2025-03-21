local function week_ascii_text()
    -- stylua ignore start
    return {
        ["Monday"] = [[
███╗   ███╗ ██████╗ ███╗   ██╗██████╗  █████╗ ██╗   ██╗
████╗ ████║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
██╔████╔██║██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ 
██║╚██╔╝██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  
██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   
╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
        ["Tuesday"] = [[
████████╗██╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗
╚══██╔══╝██║   ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
   ██║   ██║   ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝ 
   ██║   ██║   ██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝  
   ██║   ╚██████╔╝███████╗███████║██████╔╝██║  ██║   ██║   
   ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
        ["Wednesday"] = [[
██╗    ██╗███████╗██████╗ ███╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗
██║    ██║██╔════╝██╔══██╗████╗  ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
██║ █╗ ██║█████╗  ██║  ██║██╔██╗ ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝ 
██║███╗██║██╔══╝  ██║  ██║██║╚██╗██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝  
╚███╔███╔╝███████╗██████╔╝██║ ╚████║███████╗███████║██████╔╝██║  ██║   ██║   
 ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
        ["Thursday"] = [[
████████╗██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  █████╗ ██╗   ██╗
╚══██╔══╝██║  ██║██║   ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝
   ██║   ███████║██║   ██║██████╔╝███████╗██║  ██║███████║ ╚████╔╝ 
   ██║   ██╔══██║██║   ██║██╔══██╗╚════██║██║  ██║██╔══██║  ╚██╔╝  
   ██║   ██║  ██║╚██████╔╝██║  ██║███████║██████╔╝██║  ██║   ██║   
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
        ["Friday"] = [[
███████╗██████╗ ██╗██████╗  █████╗ ██╗   ██╗
██╔════╝██╔══██╗██║██╔══██╗██╔══██╗╚██╗ ██╔╝
█████╗  ██████╔╝██║██║  ██║███████║ ╚████╔╝ 
██╔══╝  ██╔══██╗██║██║  ██║██╔══██║  ╚██╔╝  
██║     ██║  ██║██║██████╔╝██║  ██║   ██║   
╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
        ["Saturday"] = [[
███████╗ █████╗ ████████╗██╗   ██╗██████╗ ██████╗  █████╗ ██╗   ██╗
██╔════╝██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝
███████╗███████║   ██║   ██║   ██║██████╔╝██║  ██║███████║ ╚████╔╝ 
╚════██║██╔══██║   ██║   ██║   ██║██╔══██╗██║  ██║██╔══██║  ╚██╔╝  
███████║██║  ██║   ██║   ╚██████╔╝██║  ██║██████╔╝██║  ██║   ██║   
╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
        ["Sunday"] = [[
███████╗██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗
██╔════╝██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
███████╗██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝ 
╚════██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝  
███████║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║   
╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ]],
    }

    -- stylua ignore end
end

local function week_header()
    local week = week_ascii_text()
    local daysoftheweek =
        { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
    local day = daysoftheweek[os.date("*t").wday]
    return week[day]
end

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            image = {
                enabled = true,
                force = true,
            },
            styles = {
                dashboard = {
                    wo = {
                        colorcolumn = "",
                    },
                },
                notification = {
                    wo = {
                        wrap = true,
                    },
                },
            },
            explorer = {
                enabled = true,
                replace_netrw = false,
            },
            picker = {
                enabled = true,
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
                        total = 100,
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
            indent = {
                scope = {
                    enabled = true,
                    animate = {
                        enabled = vim.fn.has("nvim-0.10") == 1,
                        easing = "linear",
                        duration = {
                            step = 20, -- ms per step
                            total = 200, -- maximum duration
                        },
                    },
                    underline = false,
                },
                chunk = {
                    -- when enabled, scopes will be rendered as chunks, except for the
                    -- top-level scope which will be rendered as a scope.
                    enabled = false,
                    -- only show chunk scopes in the current window
                    only_current = false,
                    hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
                    char = {
                        corner_top = "┌",
                        corner_bottom = "└",
                        -- corner_top = "╭",
                        -- corner_bottom = "╰",
                        horizontal = "─",
                        vertical = "│",
                        arrow = ">",
                    },
                },
            },
            dashboard = {
                enabled = true,
                preset = {
                    keys = {
                        {
                            icon = " ",
                            key = "f",
                            desc = "Find File",
                            action = "<leader>ff",
                        },
                        {
                            icon = " ",
                            key = "n",
                            desc = "New File",
                            action = ":ene | startinsert",
                        },
                        {
                            icon = " ",
                            key = "s",
                            desc = "Find Text",
                            action = "<leader>sg",
                        },
                        {
                            icon = " ",
                            key = "p",
                            desc = "Pick Project",
                            action = "<leader>fp",
                        },
                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = "<leader>fr",
                        },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Lazygit",
                            action = "<leader>gg",
                        },
                        {
                            icon = " ",
                            key = "G",
                            desc = "Lazygit config",
                            action = "<leader>gG",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = "<leader>fc",
                        },
                        {
                            icon = " ",
                            key = "l",
                            desc = "Restore Last Session",
                            section = "session",
                        },
                        {
                            icon = "󰒲 ",
                            key = "L",
                            desc = "Lazy",
                            action = ":Lazy",
                            enabled = package.loaded.lazy,
                        },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 2 },
                    { section = "startup", padding = 1 },
                    {
                        pane = 2,
                        align = "center",
                        title = week_header(),
                        padding = 2,
                    },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Recent Files",
                        section = "recent_files",
                        indent = 2,
                        padding = 1,
                    },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Projects",
                        section = "projects",
                        indent = 2,
                        padding = 1,
                    },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = function()
                            local ok, _ = vim.uv.fs_stat(vim.loop.cwd() .. "/.git")
                            return ok ~= nil
                        end,
                        cmd = "git status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                    {
                        pane = 2,
                        align = "center",
                        text = {
                            { " ", hl = "special" },
                            { "" .. os.date("%Y-%m-%d"), hl = "footer" },
                            { "   󰕶 ", hl = "special" },
                            { "" .. os.date("%W"), hl = "footer" },
                            { "   󰥔 ", hl = "special" },
                            { "" .. os.date("%H:%M:%S"), hl = "footer" },
                        },
                    },
                },
            },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            quickfile = { enabled = true },
            bufdelete = { enabled = true },
            scratch = {
                root = vim.fn.stdpath("data") .. "/scratch",
                name = "Scratch",
                win = {
                    width = 0.5,
                    height = 0.9,
                    style = "scratch",
                },
                ft = function()
                    if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
                        return vim.bo.filetype
                    end
                    return "markdown"
                end,
                win_by_ft = {
                    c = {
                        keys = {
                            ["gcc"] = {
                                "<cr>",
                                function(self)
                                    vim.cmd("!gcc -S %")
                                end,
                                desc = "Assembly",
                                mode = { "n", "x" },
                            },
                            ["Godbolt"] = {
                                "<leader><cr>",
                                function(self)
                                    vim.cmd("Godbolt")
                                end,
                                desc = "Godbolt",
                                mode = { "n", "x" },
                            },
                        },
                    },
                    cpp = {
                        keys = {
                            ["gcc"] = {
                                "<cr>",
                                function(self)
                                    vim.cmd("!gcc -S %")
                                end,
                                desc = "Assembly",
                                mode = { "n", "x" },
                            },
                            ["Godbolt"] = {
                                "<leader><cr>",
                                function(self)
                                    vim.cmd("Godbolt")
                                end,
                                desc = "Godbolt",
                                mode = { "n", "x" },
                            },
                        },
                    },
                    python = {
                        keys = {
                            ["run"] = {
                                "<cr>",
                                function()
                                    vim.cmd("!python3 %")
                                end,
                                desc = "Run file",
                                mode = { "n", "x" },
                            },
                        },
                    },
                    lua = {
                        keys = {
                            ["source"] = {
                                "<cr>",
                                function(self)
                                    local name = "scratch."
                                        .. vim.fn.fnamemodify(
                                            vim.api.nvim_buf_get_name(self.buf),
                                            ":e"
                                        )
                                    Snacks.debug.run({ buf = self.buf, name = name })
                                end,
                                desc = "Source buffer",
                                mode = { "n", "x" },
                            },
                        },
                    },
                },
            },
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
        },
        keys = {
            {
                "<leader>EE",
                function()
                    Snacks.explorer.open()
                end,
                desc = "Explorer",
            },
            {
                "<leader>,",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>/",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep",
            },
            {
                "<leader>:",
                function()
                    Snacks.picker.command_history()
                end,
                desc = "Command History",
            },
            -- find
            {
                "<leader>fb",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "Buffers",
            },
            {
                "<leader>fh",
                function()
                    Snacks.picker.files({ cwd = vim.fn.expand("$HOME") })
                end,
                desc = "Find home File",
            },
            {
                "<leader>fc",
                function()
                    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
                end,
                desc = "Find Config File",
            },
            {
                "<leader>ff",
                function()
                    Snacks.picker.files()
                end,
                desc = "Find Files",
            },
            {
                "<leader>fg",
                function()
                    Snacks.picker.git_files()
                end,
                desc = "Find Git Files",
            },
            {
                "<leader>fr",
                function()
                    Snacks.picker.recent()
                end,
                desc = "Recent",
            },
            -- git
            {
                "<leader>gc",
                function()
                    Snacks.picker.git_log()
                end,
                desc = "Git Log",
            },
            {
                "<leader>ga",
                function()
                    Snacks.picker.git_branches()
                end,
                desc = "Git Log",
            },
            {
                "<leader>fG",
                function()
                    Snacks.picker.git_status()
                end,
                desc = "Git Status",
            },
            -- Grep
            {
                "<leader>sb",
                function()
                    Snacks.picker.lines()
                end,
                desc = "Buffer Lines",
            },
            {
                "<leader>sB",
                function()
                    Snacks.picker.grep_buffers()
                end,
                desc = "Grep Open Buffers",
            },
            {
                "<leader>sD",
                function()
                    Snacks.picker.diagnostics_buffer()
                end,
                desc = "Buffer Diagnostics",
            },
            {
                "<leader>sg",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep",
            },
            {
                "<leader>sw",
                function()
                    Snacks.picker.grep_word()
                end,
                desc = "Visual selection or word",
                mode = { "n", "x" },
            },
            -- search
            {
                '<leader>s"',
                function()
                    Snacks.picker.registers()
                end,
                desc = "Registers",
            },
            {
                "<leader>sa",
                function()
                    Snacks.picker.autocmds()
                end,
                desc = "Autocmds",
            },
            {
                "<leader>sc",
                function()
                    Snacks.picker.command_history()
                end,
                desc = "Command History",
            },
            {
                "<leader>sC",
                function()
                    Snacks.picker.commands()
                end,
                desc = "Commands",
            },
            {
                "<leader>sd",
                function()
                    Snacks.picker.diagnostics()
                end,
                desc = "Diagnostics",
            },
            {
                "<leader>sh",
                function()
                    Snacks.picker.help()
                end,
                desc = "Help Pages",
            },
            {
                "<leader>sH",
                function()
                    Snacks.picker.highlights()
                end,
                desc = "Highlights",
            },
            {
                "<leader>sj",
                function()
                    Snacks.picker.jumps()
                end,
                desc = "Jumps",
            },
            {
                "<leader>sk",
                function()
                    Snacks.picker.keymaps()
                end,
                desc = "Keymaps",
            },
            {
                "<leader>sl",
                function()
                    Snacks.picker.loclist()
                end,
                desc = "Location List",
            },
            {
                "<leader>sM",
                function()
                    Snacks.picker.man()
                end,
                desc = "Man Pages",
            },
            {
                "<leader>sm",
                function()
                    Snacks.picker.marks()
                end,
                desc = "Marks",
            },
            {
                "<leader>sR",
                function()
                    Snacks.picker.resume()
                end,
                desc = "Resume",
            },
            {
                "<leader>sq",
                function()
                    Snacks.picker.qflist()
                end,
                desc = "Quickfix List",
            },
            {
                "<leader>fC",
                function()
                    Snacks.picker.colorschemes()
                end,
                desc = "Colorschemes",
            },
            -- LSP
            {
                "gd",
                function()
                    Snacks.picker.lsp_definitions()
                end,
                desc = "Goto Definition",
            },
            {
                "grr",
                function()
                    Snacks.picker.lsp_references()
                end,
                nowait = true,
                desc = "References",
            },
            {
                "gri",
                function()
                    Snacks.picker.lsp_implementations()
                end,
                desc = "Goto Implementation",
            },
            {
                "gy",
                function()
                    Snacks.picker.lsp_type_definitions()
                end,
                desc = "Goto T[y]pe Definition",
            },
            {
                "gO",
                function()
                    Snacks.picker.lsp_symbols()
                end,
                desc = "LSP Symbols",
            },
            {
                "<leader>ss",
                function()
                    Snacks.picker.lsp_symbols()
                end,
                desc = "LSP Symbols",
            },
            {
                "<leader>.",
                function()
                    Snacks.scratch()
                end,
                desc = "Toggle Scratch Buffer",
            },
            {
                "<leader>n",
                function()
                    Snacks.scratch.open({
                        ft = "markdown",
                        root = vim.fn.expand("$HOME/notes"),
                        autowrite = true,
                        filekey = {
                            cwd = true,
                            branch = true,
                            count = true,
                        },
                        name = "Notes",
                    })
                end,
                desc = "Toggle Notes Buffer",
            },
            {
                "<leader>S",
                function()
                    Snacks.scratch.select()
                end,
                desc = "Select Scratch Buffer",
            },
            {
                "<leader>un",
                function()
                    Snacks.notifier.hide()
                end,
                desc = "Dismiss All Notifications",
            },
            {
                "<leader>q",
                function()
                    Snacks.bufdelete()
                end,
                desc = "Delete Buffer",
            },
            {
                "<leader>gg",
                function()
                    Snacks.lazygit()
                end,
                desc = "Lazygit",
            },
            {
                "<leader>gG",
                function()
                    require("snacks").terminal("lazygit --git-dir=$HOME/.cfg --work-tree=$HOME")
                end,
                desc = "Lazygit dotfiles",
            },
            {
                "<leader>gb",
                function()
                    Snacks.git.blame_line()
                end,
                desc = "Git Blame Line",
            },
            {
                "<leader>gB",
                function()
                    Snacks.gitbrowse()
                end,
                desc = "Git Browse",
            },
            {
                "<leader>gf",
                function()
                    Snacks.lazygit.log_file()
                end,
                desc = "Lazygit Current File History",
            },
            {
                "<leader>gl",
                function()
                    Snacks.lazygit.log()
                end,
                desc = "Lazygit Log (cwd)",
            },
            {
                "<leader>fl",
                function()
                    Snacks.picker.lsp_config()
                end,
                desc = "Lsp Info",
            },
            {
                "grf",
                function()
                    Snacks.rename.rename_file()
                end,
                desc = "Rename File",
            },
            {
                "<leader>tf",
                function()
                    Snacks.terminal(nil, { win = { position = "float" } })
                end,
                desc = "Toggle Terminal (float)",
            },
            {
                "<leader>ts",
                function()
                    Snacks.terminal(nil, { win = { position = "bottom", height = 50 } })
                end,
                desc = "Toggle Terminal (bottom)",
            },
            {
                "<leader>tv",
                function()
                    Snacks.terminal(nil, { win = { position = "right", width = 90 } })
                end,
                desc = "Toggle Terminal (right)",
            },
            {
                "<leader>tt",
                function()
                    Snacks.terminal()
                end,
                desc = "Toggle Terminal",
            },
            {
                "<leader>tc",
                function()
                    Snacks.terminal(
                        vim.fn.input("Run command", "", "shellcmdline"),
                        { auto_close = false }
                    )
                end,
                desc = "Run command in terminal",
            },
            {
                "<leader>tC",
                function()
                    Snacks.terminal(
                        vim.fn.input("Run command", "", "shellcmdline"),
                        { auto_close = true }
                    )
                end,
                desc = "Run command in terminal (autoclose)",
            },
            {
                "<c-/>",
                function()
                    Snacks.terminal()
                end,
                desc = "Toggle Terminal",
            },
            {
                "<c-_>",
                function()
                    Snacks.terminal()
                end,
                desc = "which_key_ignore",
            },
            {
                "]]",
                function()
                    Snacks.words.jump(vim.v.count1)
                end,
                desc = "Next Reference",
            },
            {
                "[[",
                function()
                    Snacks.words.jump(-vim.v.count1)
                end,
                desc = "Prev Reference",
            },
            {
                "<leader>N",
                desc = "Neovim News",
                function()
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
                end,
            },
        },
        init = function()
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

                    local spinner =
                        { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
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
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
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
                    Snacks.toggle.indent():map("<leader>ui")
                    Snacks.toggle.words():map("<leader>uW")
                    Snacks.toggle.scroll():map("<leader>uS")
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle
                        .option("relativenumber", { name = "Relative Number" })
                        :map("<leader>uL")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle
                        .option(
                            "conceallevel",
                            { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
                        )
                        :map("<leader>uc")
                    Snacks.toggle.treesitter():map("<leader>uT")
                    Snacks.toggle
                        .option("background", { off = "light", on = "dark", name = "Dark Background" })
                        :map("<leader>ub")
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
                end,
            })
        end,
    },
}
