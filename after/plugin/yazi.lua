require("yazi").setup({
    open_for_directories = true,
    integrations = {
        grep_in_directory = "snacks.picker",
        grep_in_selected_files = "snacks.picker",
        picker_add_copy_relative_path_action = "snacks.picker",
        bufdelete_implementation = "snacks-if-available",
    },
})
vim.keymap.set({ "n", "v" }, "<leader>EB", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
vim.keymap.set("n", "<leader>EC", "<cmd>Yazi cwd<cr>", { desc = "Open the file manager in nvim's working directory" })
vim.keymap.set("n", "<leader>e", "<cmd>Yazi toggle<cr>", { desc = "Resume the last yazi session" })
