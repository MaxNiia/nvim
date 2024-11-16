local icons = require("utils.icons")

return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        opts = function()
            return {
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = {
                        left = icons.separator.line.left,
                        right = icons.separator.line.right,
                    },
                    section_separators = {
                        left = icons.separator.full.left,
                        right = icons.separator.full.right,
                    },
                    disabled_filetypes = {
                        statusline = {
                            "dashboard",
                            "lazy",
                            "Mason",
                        },
                        winbar = {
                            "spectre_panel",
                            "Outline",
                            "Trouble",
                            "dapui_scopes",
                            "dapui_breakpoints",
                            "dapui_stacks",
                            "dapui_console",
                            "dapui_watches",
                            "dapui_scopes",
                            "dap-repl",
                            "dashboard",
                            "terminal",
                            "toggleterm",
                            "lazy",
                        },
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = vim.o.laststatus == 3,
                    refresh = {
                        statusline = 100,
                        tabline = 100,
                        winbar = 100,
                    },
                },
                extensions = {
                    "fzf",
                    "fugitive",
                    "lazy",
                    "quickfix",
                    "toggleterm",
                    "mason",
                    "trouble",
                },
                inactive_winbar = {
                    lualine_a = {
                        {
                            "filetype",
                            icon_only = true,
                            separator = "",
                        },
                        {
                            "filename",
                            newfile_status = true,
                            path = 1,
                        },
                    },
                    lualine_b = {
                        {
                            "diff",
                        },
                        {
                            "diagnostics",
                        },
                    },
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                winbar = {
                    lualine_a = {
                        {
                            "filetype",
                            colored = false,
                            icon_only = true,
                            separator = "",
                        },
                        {
                            "filename",
                            newfile_status = true,
                            path = 1,
                        },
                    },
                    lualine_b = {
                        {
                            "diff",
                        },
                        {
                            "diagnostics",
                        },
                    },
                    lualine_c = {
                        {
                            "filesize",
                        },
                        {
                            "fileformat",
                        },
                        {
                            "encoding",
                        },
                    },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                -- Statusline
                sections = {
                    lualine_a = {
                        {
                            "tabs",
                            mode = 2,
                            path = 0,
                            use_mode_colors = true,
                            show_modified_status = true,
                            symbols = {
                                modified = icons.misc.modified,
                            },
                        },
                    },
                    lualine_b = {
                        {
                            "aerial",
                            colored = true,
                        },
                    },
                    lualine_c = {},
                    lualine_x = {
                        {
                            function()
                                return require("noice").api.status.command.get()
                            end,
                            cond = function()
                                return package.loaded["noice"]
                                    and require("noice").api.status.command.has()
                            end,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            function()
                                return require("noice").api.status.mode.get()
                            end,
                            cond = function()
                                return package.loaded["noice"]
                                    and require("noice").api.status.mode.has()
                            end,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            function()
                                return "  " .. require("dap").status()
                            end,
                            cond = function()
                                return package.loaded["dap"] and require("dap").status() ~= ""
                            end,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = { fg = "#ff9e64" },
                        },
                    },
                    lualine_y = {
                        {
                            "progress",
                        },
                        {
                            "location",
                        },
                    },
                    lualine_z = {
                        {
                            "b:gitsigns_head",
                            icon = "",
                        },
                        {
                            function()
                                local cwd = vim.uv.cwd()
                                local home = vim.fn.expand("~")
                                cwd, _ = cwd:gsub(home, "~")
                                return cwd
                            end,
                            padding = {
                                left = 1,
                                right = 1,
                            },
                        },
                        {
                            "datetime",
                            style = "%H:%M",
                        },
                    },
                },
            }
        end,
    },
}
