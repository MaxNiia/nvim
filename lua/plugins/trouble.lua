return {
    {
        "folke/trouble.nvim",
    enabled = not _G.IS_VSCODE,
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
        },
        opts = {
            auto_close = false,
            icons = true,
            use_diagnostic_signs = true,
        },
    },
}
