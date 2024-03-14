local icons = require("utils.icons")

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-neo-tree/neo-tree.nvim",
            "SmiteshP/nvim-navic",
            "AckslD/swenv.nvim",
            "catppuccin/nvim",
            "folke/noice.nvim",
        },
        lazy = true,
        event = "BufEnter",
        enabled = not vim.g.vscode,
        opts = {
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
                        "aerial",
                    },
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            extensions = {
                "aerial",
                "fzf",
                "fugitive",
                "lazy",
                "neo-tree",
                "quickfix",
                "toggleterm",
                "trouble",
            },
            -- Statusline
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        function()
                            local venv = require("swenv.api").get_current_venv()
                            if venv then
                                return string.format(icons.misc.python .. "%s", venv.name)
                            else
                                return ""
                            end
                        end,
                    },
                    {
                        "b:gitsigns_head",
                        icon = "",
                    },
                    {

                        function()
                            return "Session: " .. require("resession").get_current()
                        end,
                    },
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    {
                        function()
                            return require("noice").api.statusline.mode.get()
                        end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.statusline.mode.has()
                        end,
                    },
                    {
                        function()
                            return require("noice").api.status.command.get()
                        end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.command.has()
                        end,
                    },
                    {
                        "progress",
                    },
                    {
                        "location",
                    },
                },
                lualine_z = {
                    {
                        function()
                            return icons.misc.clock .. os.date("%R")
                        end,
                    },
                },
            },
            inactive_sections = {},
            -- Winbar
            winbar = {
                lualine_a = {
                    --     {
                    --         "fileformat",
                    --         separator = "",
                    --         padding = {
                    --             left = 1,
                    --             right = 0,
                    --         },
                    --     },
                    --     {
                    --         "filetype",
                    --         colored = false,
                    --         icon_only = true,
                    --         icon = { align = "right" },
                    --         separator = "",
                    --         padding = {
                    --             left = 1,
                    --             right = 0,
                    --         },
                    --     },
                    --     {
                    --         "filename",
                    --         file_status = true,
                    --         path = 1,
                    --         shortng_target = 40,
                    --         symbols = icons.files,
                    --     },
                },
                lualine_b = {
                    --     {
                    --         "diagnostics",
                    --         symbols = icons.diagnostics,
                    --         separator = icons.separator.bar,
                    --     },
                    --     {
                    --         "diff",
                    --         symbols = icons.git,
                    --         source = function()
                    --             local gitsigns = vim.b.gitsigns_status_dict
                    --             if gitsigns then
                    --                 return {
                    --                     added = gitsigns.added,
                    --                     modified = gitsigns.changed,
                    --                     removed = gitsigns.removed,
                    --                 }
                    --             end
                    --         end,
                    --     },
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            inactive_winbar = {
                lualine_a = {
                    -- {
                    --     "filetype",
                    --     colored = false,
                    --     icon_only = true,
                    --     icon = { align = "right" },
                    -- },
                    -- {
                    --     "filename",
                    --     file_status = true,
                    --     path = 1,
                    --     shortng_target = 40,
                    --     symbols = icons.files,
                    -- },
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            -- Tabline
            tabline = {
                lualine_a = {
                    {
                        vim.loop.cwd,
                        type = "vim_fun",
                        padding = {
                            left = 1,
                            right = 1,
                        },
                    },
                },
                lualine_b = {
                    {
                        "g:gitsigns_head",
                        icon = "",
                    },
                },
                lualine_c = {
                    {
                        "navic",
                        color_correction = "dynamic",
                        navic_opts = {
                            highlight = true,
                            click = true,
                        },
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {
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
            },
        },
    },
}
