return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        cond = not vim.g.vscode,
        event = "BufEnter",
        keys = {
            {
                "<leader>Gc",
                "<cmd>G commit<cr>",
                desc = "Git commit",
            },
            {
                "<leader>Gl",
                "<cmd>G! log --max-count=50<cr>",
                desc = "Git log",
            },
            {
                "<leader>Gs",
                "<cmd>G! status<cr>",
                desc = "Git status",
            },
            {
                "<leader>Gp",
                "<cmd>G! push",
                desc = "Git push",
            },
            {
                "<leader>GP",
                "<cmd>G! push --force-with-lease<cr>",
                desc = "Git push force",
            },
            {
                "<leader>Gf",
                "<cmd>G! pull<cr>",
                desc = "Git pull",
            },
        },
    },
    {
        "cedarbaum/fugitive-azure-devops.vim",
    },
}
