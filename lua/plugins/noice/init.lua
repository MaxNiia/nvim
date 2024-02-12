return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = function()
            local _opts = {
                presets = {
                    command_palette = false,
                    long_message_to_split = false,
                    inc_rename = false,
                    long_message_to_split = true,
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
            }
            if _G.popup then
                _opts = vim.tbl_deep_extend("force", _opts, require("plugins.noice.popup"))
            else
                _opts = vim.tbl_deep_extend("force", _opts, require("plugins.noice.bottom"))
            end
            return _opts
        end,
    },
}
