return {
    {
        "mikavilpas/yazi.nvim",
        cond = (not vim.g.vscode) and OPTIONS.yazi.value,
        keys = {
            {
                "<leader>e",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
            {
                "<leader>EC",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                "<leader>EB",
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
        },
    },
}
