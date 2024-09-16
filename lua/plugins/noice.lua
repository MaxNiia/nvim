local icons = require("utils.icons").diagnostics

return {
    {
        "folke/noice.nvim",
        event = "BufEnter",
        opts = {
            presets = {
                command_palette = false,
                inc_rename = true,
                long_message_to_split = true,
                bottom_search = true,
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
                view = "cmdline",
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
                        style = "rounded",
                        padding = { 0, 0 },
                    },
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
        },
    },
}
