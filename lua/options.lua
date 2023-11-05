local set = vim.opt

set.ai = true
set.autowriteall = true
set.backspace = "indent,eol,start"
set.belloff = "all"
set.cmdheight = 0
set.colorcolumn = "+1"
set.cul = true
set.culopt = "both"
set.expandtab = true
set.ignorecase = true
set.incsearch = true
set.laststatus = 3
set.number = false
set.numberwidth = 2
set.rnu = true
set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true
set.pumblend = 0
set.ruler = false
set.shiftwidth = 4
set.smartcase = true
set.smartindent = true
set.smarttab = true
set.softtabstop = 4
set.spell = true
set.spelloptions = "camel"
set.splitbelow = true
set.splitright = true
set.termguicolors = true
set.textwidth = 80
set.signcolumn = "no"--"yes:1"
set.swapfile = false
set.cursorline = false
set.clipboard = "unnamed"
set.scrolloff = 5

local cmd = vim.cmd

cmd([[
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
    autocmd FileType python set textwidth=120
    autocmd FileType python set colorcolumn=+1
]])

cmd([[
    autocmd FileType lua set textwidth=120
    autocmd FileType lua set colorcolumn=+1
]])

cmd([[
    autocmd FileType neo-tree set numberwidth=2
    autocmd FileType neo-tree set scl=no
]])
