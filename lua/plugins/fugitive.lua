local group_key = "g"
if _G.neotree then
    group_key = "H"
end

return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        event = "BufEnter",
        keys = {
            {
                "<leader>" .. group_key .. "c",
                "<cmd>G commit<cr>",
                desc = "Git commit",
            },
            {
                "<leader>" .. group_key .. "l",
                "<cmd>G log",
                desc = "Git log",
            },
        },
    },
    {
        "cedarbaum/fugitive-azure-devops.vim",
    },
}
