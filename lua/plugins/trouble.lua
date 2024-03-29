return {
    {
        "folke/trouble.nvim",
        enabled = not vim.g.vscode,
        branch = "dev",
        event = "BufEnter",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
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
                    require("trouble").previous({ skip_groups = true, jump = true })
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
        },
    },
}
