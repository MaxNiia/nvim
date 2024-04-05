local icons = require("utils.icons")

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "AckslD/swenv.nvim",
            "catppuccin/nvim",
            "folke/noice.nvim",
            "folke/trouble.nvim",
            "nvim-neo-tree/neo-tree.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = true,
        event = "BufEnter",
        enabled = not vim.g.vscode,
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
                    theme = "catppuccin",
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
                            vim.uv.cwd,
                            type = "vim_fun",
                            padding = {
                                left = 1,
                                right = 1,
                            },
                        },
                        {
                            "g:gitsigns_head" .. ":" .. "b:gitsigns_head",
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
                    },
                    lualine_c = {
                        { symbols.get, cond = symbols.has },
                    },
                    lualine_x = {
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
                                return icons.misc.clock .. os.date("%R")
                            end,
                        },
                    },
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
            }
        end,
    },
}
