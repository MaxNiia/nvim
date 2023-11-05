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
vim.opt.clipboard = "unnamed"
vim.opt.scrolloff = 5
vim.opt.mousemodel = "extend"

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
    autocmd FileType lua setlocal textwidth=120
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

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = {"\\[dap-repl]\\", "DAP *"},
    callback = function(_)
        vim.wo.spell=false
    end,
})

function ToggleTroubleAuto()
    local buftype = "quickfix"
    if vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0 then
        buftype = "loclist"
    end

    local ok, trouble = pcall(require, "trouble")
    if ok then
        vim.api.nvim_win_close(0, true)
        trouble.toggle(buftype)
    else
        local set = vim.opt_local
        set.colorcolumn = ""
        set.number = false
        set.relativenumber = false
        set.signcolumn = "no"
    end
end

vim.cmd([[
    autocmd BufWinEnter quickfix silent :lua ToggleTroubleAuto()
]])
