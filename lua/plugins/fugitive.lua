local group_key = "g"
if _G.neotree then
    group_key = "H"
end

return { {
    "tpope/vim-fugitive",
    keys = {
        {
            "<leader>".. group_key .. "c",
                "<cmd>G commit<cr>",
            desc = "Git commit",
        },
    
    },
}, {
    "cedarbaum/fugitive-azure-devops.vim",
} }
