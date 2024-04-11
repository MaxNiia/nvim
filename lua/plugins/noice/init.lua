local icons = require("utils.icons").diagnostics

return {
    {
        "rcarriga/nvim-notify",
        cond = not vim.g.vscode,
        lazy = true,
        event = "VeryLazy",
        opts = {
            icons = {
                ERROR = icons.Error,
                WARN = icons.Warn,
                INFO = icons.Info,
            },
            render = "wrapped-compact",
            timeout = 3000,
        },
    },
    {
        "folke/noice.nvim",
        event = "BufEnter",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = function()
            local _opts = {
                presets = {
                    command_palette = false,
                    inc_rename = false,
                    long_message_to_split = true,
                },
                popupmenu = {
                    enabled = true,
                    backend = "nui",
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            kind = "",
                            find = "written",
                        },
                        opts = { skip = true },
                    },
                },
                cmdline = {
                    format = {
                        git = {
                            pattern = {
                                "^:%s*Gi?t?!?%s+",
                            },
                            icon = "",
                            lang = "git",
                        },
                    },
                },
                views = {
                    popup = {
                        border = {
                            style = "none",
                            padding = { 1, 1 },
                        },
                        win_options = {
                            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                        },
                    },
                    popupmenu = {
                        border = {
                            style = "none",
                            padding = { 1, 1 },
                        },
                        win_options = {
                            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                        },
                    },
                },
            }
            if OPTIONS.popup.value then
                _opts = vim.tbl_deep_extend("force", require("plugins.noice.popup"), _opts or {})
                    or {}
            else
                _opts = vim.tbl_deep_extend("force", require("plugins.noice.bottom"), _opts or {})
                    or {}
            end
            return _opts
        end,
    },
}
