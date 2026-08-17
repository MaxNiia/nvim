require("yazi").setup({
    open_for_directories = false,
})
vim.keymap.set({ "n", "v" }, "<leader>EB", "<cmd>Yazi<cr>", { desc = "Buffer" })
vim.keymap.set("n", "<leader>EC", "<cmd>Yazi cwd<cr>", { desc = "CWD" })
vim.keymap.set("n", "<leader>e", "<cmd>Yazi toggle<cr>", { desc = "Yazi" })
