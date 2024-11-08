local icons = require("utils.icons")

return {
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        -- event = "BufEnter",
        cond = not vim.g.vscode,
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
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
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
                tabline = {
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
                        { "aerial", colored = true },
                    },
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
                    lualine_a = { "buffers" },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {
                        {
                            function()
                                return "󰑓 "
                                    .. (require("resession").get_current() ~= nil and "On" or "Off")
                            end,
                        },
                        {
                            function()
                                return require("plugins.lualine.copilot").get_status()
                            end,
                        },
                    },
                    lualine_y = {
                        {
                            "location",
                        },
                        {
                            "progress",
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
