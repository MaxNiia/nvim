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
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = function()
            local _opts = {
                presets = {
                    command_palette = false,
                    inc_rename = true,
                    long_message_to_split = true,
                },
                popupmenu = {
                    enabled = true,
                    backend = "nui",
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            any = {
                                { find = "%d+L, %d+B" },
                                { find = "; after #%d+" },
                                { find = "; before #%d+" },
                            },
                        },
                        view = "mini",
                    },
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
                    mini = {
                        position = {
                            col = "100%",
                            row = "80%",
                        },
                    },
                    popup = {
                        border = {
                            style = "rounded",
                            padding = { 0, 0 },
                        },
                        -- win_options = {
                        --     winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                        -- },
                    },
                    popupmenu = {
                        backend = "cmp",
                        border = {
                            style = "rounded",
                            padding = { 0, 0 },
                        },
                        win_options = {
                            winhighlight = {
                                NormalFloat = "NormalFloat",
                                FloatBorder = "FloatBorder",
                            },
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
