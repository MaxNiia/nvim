vim.cmd([[
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType gitcommit setlocal colorcolumn=+1

    autocmd FileType c setlocal textwidth=80
    autocmd FileType c setlocal colorcolumn=+1

    autocmd FileType cpp setlocal textwidth=80
    autocmd FileType cpp setlocal colorcolumn=+1

    autocmd FileType python setlocal textwidth=120
    autocmd FileType python setlocal colorcolumn=+1

    autocmd FileType lua setlocal textwidth=100
    autocmd FileType lua setlocal colorcolumn=+1

    autocmd FileType neo-tree setlocal numberwidth=2
    autocmd FileType neo-tree setlocal scl=no

    autocmd FileType qf setlocal nonu
    autocmd FileType qf setlocal nornu

    autocmd FileType markdown setlocal conceallevel=2
    autocmd FileType markdown setlocal textwdith=120
    autocmd FileType markdown setlocal colorcolumn=+1

    autocmd User TelescopePreviewerLoaded setlocal wrap
    autocmd User TelescopePreviewerLoaded setlocal wrap

    autocmd CmdwinEnter * nnoremap <CR> <CR>

    autocmd BufReadPost quickfix nnoremap <CR> <CR>

    autocmd TermOpen * setlocal nospell
    autocmd TermOpen * setlocal nornu
    autocmd TermOpen * setlocal nonu

    autocmd VimLeavePre * lua require("utils.config").save_config()
]])

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = { "\\[dap-repl]\\", "DAP *" },
    callback = function(_)
        vim.wo.spell = false
    end,
})

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
