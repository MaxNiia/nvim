local key = vim.keymap.set

key({ "n", "v", "o" }, "H", "^", { desc = "End of line" })

key({ "n", "v", "o" }, "L", "$", { desc = "Start of line" })

key("n", "<c-h>", "<c-w>h", { desc = "Go to Left Window" })

key("n", "<c-j>", "<c-w>j", { desc = "Go to Lower Window" })

key("n", "<c-k>", "<c-w>k", { desc = "Go to Upper Window" })

key("n", "<c-l>", "<c-w>l", { desc = "Go to Right Window" })

key("n", "<m-down>", "<c-w>-", { desc = "Decrease height" })

key("n", "<m-up>", "<c-w>+", { desc = "Increase height" })

key("n", "<m-right>", "<c-w>>", { desc = "Increase width" })

key("n", "<m-left>", "<c-w><", { desc = "Decrease width" })

key("n", "<m-J>", "<c-w>=", { desc = "Equal height" })

key("n", "<m-K>", "<c-w>_", { desc = "Max height" })

key("n", "<m-L>", "<c-w>|", { desc = "Max width" })

key("v", "<", "<gv", {})

key("v", ">", ">gv", {})

key("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })

key("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

key("t", "<esc>", "<c-\\><c-n>", {})

key({ "n", "v", "o" }, "Q", "<cmd>wq<cr>", { desc = "Save and quit buffer" })

key("n", "<leader>Q", "<cmd>%bd|e#|bd#<cr>", { desc = "Delete Buffer" })

key({ "n", "v", "o" }, "<leader>y", '"+y', { desc = "Yank to system" })

key({ "n", "v", "o" }, "<leader>p", '"+p', { desc = "Paste from system" })

key("n", "<leader>H", "<cmd>nohl<CR>", { desc = "Clear highlighting" })

key("n", "k", function()
    return vim.v.count > 0 and "k" or "gk"
end, { expr = true })

key("n", "j", function()
    return vim.v.count > 0 and "j" or "gj"
end, { expr = true })
