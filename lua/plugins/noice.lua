return {
    {
        "folke/noice.nvim",
        event = "BufEnter",
        opts = {
            presets = {
                command_palette = false,
                bottom_search = true,
                inc_rename = false,
                long_message_to_split = true,
                lsp_doc_border = false,
            },
            popupmenu = {
                enabled = true,
                backend = "cmp",
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
                notify = {
                    replace = true,
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
                        style = "none",
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
