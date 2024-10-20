return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        cond = not vim.g.vscode,
        event = "BufEnter",
        keys = {
            {
                "<leader>gc",
                "<cmd>G commit<cr>",
                desc = "Git commit",
            },
            {
                "<leader>gl",
                "<cmd>G! log --max-count=50<cr>",
                desc = "Git log",
            },
            {
                "<leader>G",
                "<cmd>G<cr>",
                desc = "Git status",
            },
            {
                "<leader>gg",
                "<cmd>G<cr>",
                desc = "Git status",
            },
            {
                "<leader>gP",
                "<cmd>G! push --force-with-lease<cr>",
                desc = "Git push force",
            },
            {
                "<leader>gF",
                "<cmd>G! pull<cr>",
                desc = "Git pull",
            },
        },
    },
    {
        "cedarbaum/fugitive-azure-devops.vim",
    },
    {
        "tpope/vim-rhubarb",
    },
}
