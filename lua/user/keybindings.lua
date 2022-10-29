local map = vim.api.nvim_set_keymap

map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local options = { 
	noremap  = true, 
}

map('n', '<Leader><esc>', ':nohlsearch<cr>', options)


