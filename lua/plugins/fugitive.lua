local group_key = "g"
if _G.neotree then
    group_key = "H"
end

return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        enabled = not _G.IS_VSCODE,
        event = "BufEnter",
        keys = {
            {
                "<leader>" .. group_key .. "c",
                "<cmd>G! commit<cr>",
                desc = "Git commit",
            },
            {
                "<leader>" .. group_key .. "l",
                "<cmd>G! log --max-count=500<cr>",
                desc = "Git log",
            },
            {
                "<leader>" .. group_key .. "bp",
                "<cmd>G! push<cr>",
                desc = "Git push",
            },
            {
                "<leader>" .. group_key .. "bP",
                "<cmd>G! push --force-with-lease<cr>",
                desc = "Git push force",
            },
            {
                "<leader>" .. group_key .. "bf",
                "<cmd>G! fetch<cr>",
                desc = "Git fetch",
            },
            {
                "<leader>" .. group_key .. "bF",
                "<cmd>G! pull<cr>",
                desc = "Git pull",
            },
        },
    },
    {
        "cedarbaum/fugitive-azure-devops.vim",
    },
}
