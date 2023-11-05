vim.opt.compatible = false
vim.opt.ai = true
vim.opt.autowriteall = true
vim.opt.hidden = true
vim.opt.backspace = "indent,eol,start"
vim.opt.belloff = "all"
vim.opt.cmdheight = 0
vim.opt.colorcolumn = "+1"
vim.opt.cul = true
vim.opt.culopt = "both"
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.rnu = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.pumblend = 0
vim.opt.ruler = false
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.spelloptions = "camel"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.textwidth = 80
vim.opt.signcolumn = "yes:1"
vim.opt.foldcolumn = "auto:1"
vim.opt.swapfile = false
vim.opt.cursorline = true
vim.opt.scrolloff = 1
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 2
vim.opt.mousemodel = "extend"
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100
vim.opt.wildmenu = true
vim.opt.autoread = true
vim.opt.history = 1000
vim.opt.tabpagemax = 50
vim.opt.timeout = true
vim.opt.timeoutlen = 100

vim.cmd([[
    set display+=truncate
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    set formatoptions+=j
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
    set complete-=i
    set nrformats-=octal
]])

-- Window
vim.wo.spell = true

vim.cmd([[
    autocmd BufRead,BufNewFile *.bqn setf bqn
    autocmd BufRead,BufNewFile * if getline(1) =~ '^#!.*bqn$' | setf bqn | endif
]])

vim.cmd([[
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType gitcommit setlocal colorcolumn=+1
]])

vim.cmd([[
    autocmd FileType c setlocal textwidth=80
    autocmd FileType c setlocal colorcolumn=+1
]])

vim.cmd([[
    autocmd FileType cpp setlocal textwidth=80
    autocmd FileType cpp setlocal colorcolumn=+1
]])

vim.cmd([[
    autocmd FileType python setlocal textwidth=120
    autocmd FileType python setlocal colorcolumn=+1
]])

vim.cmd([[
    autocmd FileType lua setlocal textwidth=100
    autocmd FileType lua setlocal colorcolumn=+1
]])

vim.cmd([[
    autocmd FileType neo-tree setlocal numberwidth=2
    autocmd FileType neo-tree setlocal scl=no
]])

vim.cmd([[
    autocmd FileType qf setlocal nonu
    autocmd FileType qf setlocal nornu
]])

vim.cmd([[
    autocmd User TelescopePreviewerLoaded setlocal wrap
]])

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = { "\\[dap-repl]\\", "DAP *" },
	callback = function(_)
		vim.wo.spell = false
	end,
})

vim.cmd([[
    autocmd TermOpen * setlocal nospell
]])

vim.cmd([[
    autocmd FileType help wincmd L
    autocmd FileType fugitive wincmd L
]])

function ToggleTroubleAuto()
	local ok, trouble = pcall(require, "trouble")
	if ok then
		vim.defer_fn(function()
			vim.cmd("cclose")
			trouble.open("quickfix")
		end, 0)
	end
end

vim.cmd([[
    autocmd BufWinEnter quickfix silent :lua ToggleTroubleAuto()
]])

local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})
--
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})
