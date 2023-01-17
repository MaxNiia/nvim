local set = vim.opt

set.ai = true
set.autowriteall = true
set.backspace = "indent,eol,start"
set.belloff = "all"
set.clipboard = "unnamedplus"
set.cmdheight = 0
set.colorcolumn = "+1"
set.cul = true
set.culopt = "both"
set.expandtab = false
set.ignorecase = true
set.incsearch = true
set.laststatus = 3
set.number = true
set.numberwidth = 4
set.pumblend = 0
set.rnu = true
set.ruler = false
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
set.signcolumn = "yes"
set.swapfile = false
set.cursorline = false
set.clipboard = "unnamed"

local cmd = vim.cmd

cmd ([[
	autocmd BufRead,BufNewFile *.bqn setf bqn
	autocmd BufRead,BufNewFile * if getline(1) =~ '^#!.*bqn$' | setf bqn | endif
]])

cmd([[
	autocmd FileType gitcommit set textwidth=72
	autocmd FileType gitcommit set colorcolumn=+1
]])

cmd([[
	autocmd FileType c set textwidth=80
	autocmd FileType c set colorcolumn=+1
]])

cmd([[
	autocmd FileType cpp set textwidth=80
	autocmd FileType cpp set colorcolumn=+1
]])

cmd([[
	autocmd FileType NvimTree set numberwidth=3
   autocmd FileType NvimTree set colorcolumn=+1
]])
