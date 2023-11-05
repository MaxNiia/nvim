local set = vim.opt

set.shiftwidth = 3
set.tabstop = 3
set.expandtab = true

local cmd = vim.cmd

cmd([[
	autocmd FileType py set textwidht=120
	autocmd FileType py set colorcolumn=+1
]])
