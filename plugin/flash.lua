require("flash").setup({
    label = {
        rainbow = {
            enabled = true,
            -- number between 1 and 9
            shade = 5,
        },
    },
})

vim.keymap.set({ "n", "x", "o" }, "zk", function()
    require("flash").jump()
end, { desc = "Jump" })
vim.keymap.set({ "n", "x", "o" }, "zK", function()
    require("flash").treesitter()
end, { desc = "Jump Treesitter" })
vim.keymap.set("o", "r", function()
    require("flash").remote()
end, { desc = "Remote" })
vim.keymap.set({ "o", "x" }, "R", function()
    require("flash").treesitter_search()
end, { desc = "Treesitter search" })
vim.keymap.set("c", "<c-/>", function()
    require("flash").toggle()
end, { desc = "Remote" })
