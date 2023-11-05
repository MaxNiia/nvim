local set = vim.opt

set.ai = true
set.backspace = "indent,eol,start"
set.belloff = "all"
set.clipboard = "unnamedplus"
set.cmdheight = 3
set.colorcolumn = "+1"
set.expandtab = false
set.ignorecase = true
set.incsearch = true
set.number = true
set.numberwidth = 4
set.pumblend = 50
set.rnu = true
set.ruler = false
set.shiftwidth = 8
set.smartcase = true
set.smartindent = true
set.smarttab = true
set.softtabstop = 0
set.spell = true
set.spelloptions = "camel"
set.splitbelow = true
set.splitright = true
set.termguicolors = true
set.textwidth = 80

local cmd = vim.cmd
cmd [[
	autocmd FileType gitcommit set textwidth=72
	autocmd FileType gitcommit set colorcolumn=+1
]]

cmd [[
	autocmd FileType c set textwidth=80
	autocmd FileType c set colorcolumn=+1
]]

cmd [[
	autocmd FileType cpp set textwidth=80
	autocmd FileType cpp set colorcolumn=+1
]]

cmd [[
	autocmd FileType py set textwidht=88
	autocmd FileType py set colorcolumn=+1
]]

