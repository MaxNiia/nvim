return {
    {
        "MaxNiia/trouble.nvim",
        cond = not vim.g.vscode,
        event = "BufEnter",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xd",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>xs",
                "<cmd>Trouble symbols toggle focus=false win.position=left<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>xl",
                "<cmd>Trouble lsp toggle focus=false win.position=left<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
            {
                "]a",
                function()
                    require("trouble").next({ skip_groups = true, jump = true })
                end,
                desc = "Next trouble",
            },
            {
                "[A",
                function()
                    require("trouble").first({ skip_groups = true, jump = true })
                end,
                desc = "First trouble",
            },
            {
                "[a",
                function()
                    require("trouble").prev({ skip_groups = true, jump = true })
                end,
                desc = "Previous trouble",
            },
            {
                "]A",
                function()
                    require("trouble").last({ skip_groups = true, jump = true })
                end,
                desc = "Last trouble",
            },
        },
        opts = {
            modes = {
                diagnostics = {
                    sort = { "severity", "filename", "pos", "message" },
                },
                quickfix = {
                    sort = { "pos", "filename", "severity", "message" },
                },
                loclist = {
                    sort = { "pos", "filename", "severity", "message" },
                },
                todo = {
                    sort = { "pos", "filename", "severity", "message" },
                },
            },
        },
        specs = {
            "folke/snacks.nvim",
            opts = function(_, opts)
                return vim.tbl_deep_extend("force", opts or {}, {
                    picker = {
                        actions = require("trouble.sources.snacks").actions,
                        win = {
                            input = {
                                keys = {
                                    ["<c-t>"] = {
                                        "trouble_open",
                                        mode = { "n", "i" },
                                    },
                                },
                            },
                        },
                    },
                })
            end,
        },
    },
}
