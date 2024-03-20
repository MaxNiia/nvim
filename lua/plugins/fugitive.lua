local group_key = "g"
if OPTIONS.neotree.value then
    group_key = "H"
end

return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        enabled = not vim.g.vscode,
        event = "BufEnter",
        keys = {
            {
                "<leader>" .. group_key .. "c",
                "<cmd>G commit<cr>",
                desc = "Git commit",
            },
            {
                "<leader>" .. group_key .. "l",
                "<cmd>G! log --max-count=50<cr>",
                desc = "Git log",
            },
            {
                "<leader>" .. group_key .. "bp",
                "<cmd>G! push --force-with-lease<cr>",
                desc = "Git push force",
            },
            {
                "<leader>" .. group_key .. "bf",
                "<cmd>G! pull<cr>",
                desc = "Git pull",
            },
        },
    },
    {
        "cedarbaum/fugitive-azure-devops.vim",
    },
}
