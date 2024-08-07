local icons = require("utils.icons")

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "AckslD/swenv.nvim",
            "folke/noice.nvim",
            "folke/trouble.nvim",
            "echasnovski/mini.icons",
        },
        lazy = true,
        event = "BufEnter",
        cond = not vim.g.vscode,
        opts = function()
            local trouble = require("trouble")
            local symbols = trouble.statusline({
                mode = "lsp_document_symbols",
                groups = {},
                title = false,
                filter = { range = true },
                format = "{kind_icon}{symbol.name:Normal}>",
            })

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
                    lualine_b = {},
                    lualine_c = {
                        { symbols.get, cond = symbols.has },
                    },
                    lualine_z = {},
                },
                -- Statusline
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
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
                            "b:gitsigns_head",
                            icon = "",
                        },
                        {

                            function()
                                return "󰑓 "
                                    .. (
                                        require("resession").get_current() ~= nil and "Active"
                                        or "Inactive"
                                    )
                            end,
                        },
                        {
                            function()
                                local venv = require("swenv.api").get_current_venv()
                                if venv then
                                    return string.format(icons.misc.python .. "%s", venv.name)
                                else
                                    return ""
                                end
                            end,
                            cond = function()
                                return vim.bo.filetype == "python"
                            end,
                        },
                        {
                            function()
                                return require("plugins.lualine.copilot").get_status()
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
                                return icons.misc.clock .. os.date()
                            end,
                        },
                    },
                },
            }
        end,
    },
}
