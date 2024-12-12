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
            bigfile = { enabled = true },
            scroll = {
                animate = {
                    duration = {
                        step = 20,
                        total = 200,
                    },
                    easing = "linear",
                },
            },
            input = {},
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
                            action = ":lua Snacks.dashboard.pick('files')",
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
                            action = ":lua Snacks.dashboard.pick('live_grep')",
                        },
                        {
                            icon = " ",
                            key = "p",
                            desc = "Pick Project",
                            action = "<leader>WP",
                        },
                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')",
                        },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Lazygit",
                            action = "<leader>gg",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
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
                            return ok
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
            notifier = { enabled = true, timeout = 3000 },
            quickfile = { enabled = true },
            bufdelete = { enabled = true },
            scratch = {
                win = {
                    width = 100,
                    height = 60,
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
                                function(self)
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
                right = { "git", "fold" }, -- priority of signs on the right (high to low)
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
                "<leader>.",
                function()
                    Snacks.scratch()
                end,
                desc = "Toggle Scratch Buffer",
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
                "<leader>rf",
                function()
                    Snacks.rename.rename_file()
                end,
                desc = "Rename File",
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
                    Snacks.toggle.zen():map("<leader>z")
                    Snacks.toggle.zoom():map("<leader>Z")
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
                end,
            })
        end,
    },
}
