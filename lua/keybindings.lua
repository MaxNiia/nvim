local map = vim.api.nvim_set_keymap

map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local wk = require("which-key")
wk.register({
	c = {
		"<cm:wqd>nohlsearch<CR>",
		"Clear highlight",
	},
	s = {
		"<cmd>wall<CR>",
		"Save all"
	},
}, {
	prefix = "<leader>",
})
