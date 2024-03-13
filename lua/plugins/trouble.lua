return {
    {
        "folke/trouble.nvim",
        enabled = not vim.g.vscode,
        event = "BufEnter",
        keys = {
            {
                "<leader>xx",
                "<cmd>TroubleToggle<cr>",
                desc = "Trouble",
            },
            {
                "<leader>xw",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                desc = "Workspace",
            },
            {
                "<leader>xd",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                desc = "Document",
            },
            {
                "<leader>xq",
                "<cmd>TroubleToggle quickfix<cr>",
                desc = "Quickfix",
            },
            {
                "<leader>xl",
                "<cmd>TroubleToggle loclist<cr>",
                desc = "Loc list",
            },
            {
                "<leader>xr",
                "<cmd>TroubleToggle lsp_references<cr>",
                desc = "References",
            },
            {
                "]a",
                function()
                    require("trouble").next({ skip_groups = true, jump = true })
                end,
                desc = "Next trouble",
            },
            {
                "]A",
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
                "[A",
                function()
                    require("trouble").last({ skip_groups = true, jump = true })
                end,
                desc = "Last trouble",
            },
        },
        opts = {
            auto_close = false,
            icons = true,
            use_diagnostic_signs = true,
        },
    },
}
