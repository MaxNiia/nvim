return {
    {
        "folke/noice.nvim",
        cond = not vim.g.vscode,
        event = "VeryLazy",
        keys = {
            {
                "<leader>fn",
                "<cmd>NoicePick<cr>",
                desc = "Messages",
                mode = "n",
            },
        },
        opts = {
            presets = {
                bottom_search = not vim.g.noice_popup,
                command_palette = false,
                inc_rename = false,
                long_message_to_split = true,
                lsp_doc_border = false,
            },
            popupmenu = {
                enabled = true,
                backend = "cmp",
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                ["vim.lsp.util.stylize_markdown"] = false,
                ["cmp.entry.get_documentation"] = true,
            },
            lsp = {
                progress = {
                    enabled = false,
                },
            },
            messages = {
                enabled = true, -- enables the Noice messages UI
                view = "notify", -- default view for messages
                view_error = "notify", -- view for errors
                view_warn = "notify", -- view for warnings
                view_history = "messages", -- view for :messages
                view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
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
                },
                {
                    view = "split",
                    filter = { event = "msg_show", min_height = 20 },
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
                view = vim.g.noice_popup and "cmdline_popup" or "cmdline",
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
                },
                cmdline_popup = {
                    border = {
                        style = "none",
                        padding = { 1, 1 },
                    },
                    filter_options = {},
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                    },
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
