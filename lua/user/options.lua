local set = vim.opt

set.shiftwidth = 8
set.softtabstop = 0

local cmd = vim.cmd

cmd([[
	autocmd FileType py set textwidht=88
	autocmd FileType py set colorcolumn=+1
]])
