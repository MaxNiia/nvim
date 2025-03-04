-- Global
vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Options
vim.opt.ai = true
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.autowriteall = true
vim.opt.backspace = "indent,eol,start"
vim.opt.belloff = "all"
vim.opt.cmdheight = 0
vim.opt.colorcolumn = "+1"
vim.opt.compatible = false
vim.opt.cul = true
vim.opt.culopt = "both"
-- vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.foldcolumn = "auto:1"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.opt.hidden = true
vim.opt.smoothscroll = true
vim.opt.history = 1000
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.mousemodel = "extend"
vim.opt.number = vim.g.nu
vim.opt.rnu = vim.g.rnu
vim.opt.numberwidth = 2
vim.opt.pumblend = 0
vim.opt.ruler = true
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 4
vim.opt.showtabline = 0
vim.opt.showcmd = true
vim.opt.showcmdloc = "statusline"
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 2
vim.opt.signcolumn = "yes:1"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.spelloptions = "camel"
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabpagemax = 50
vim.opt.tabstop = 8
vim.opt.termguicolors = true
vim.opt.textwidth = 80
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100
vim.opt.undofile = true
vim.opt.wildmenu = true
vim.opt.winblend = 0
vim.opt.diffopt = "filler,internal,closeoff,algorithm:histogram,context:5,linematch:60"

local icons = require("niia.utils.icons")
vim.opt.fillchars:append({
    diff = icons.misc.slash,
    foldopen = icons.fold.open,
    foldclose = icons.fold.closed,
    foldsep = icons.fold.separator,
})
vim.opt.listchars:append({
    tab = icons.chevron.right .. " ",
    trail = icons.misc.minus,
    extends = icons.chevron.right,
    precedes = icons.chevron.left,
    nbsp = icons.misc.plus,
})

-- Window
vim.wo.spell = true

vim.cmd([[
    set display+=truncate
    set formatoptions+=j
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
    set complete-=i
    set nrformats-=octal
    set sessionoptions-=options
    set viewoptions-=options
]])

if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.o.shell = "powershell.exe"
end
