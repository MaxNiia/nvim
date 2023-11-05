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

-- vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })
