vim.cmd([[
    augroup TerminalOptions
        autocmd TermOpen * setlocal nospell
        autocmd TermOpen * setlocal nornu
        autocmd TermOpen * setlocal nonu
    augroup END

    augroup BgHighlight
        autocmd!
        autocmd WinEnter * set cul
        autocmd WinLeave * set nocul
    augroup END

    augroup zoom
        autocmd!
        autocmd VimResized * wincmd =
    augroup END

    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
]])

vim.cmd([[
function! HighlightAsanLeakOutput()
  " Stack frame like: #0, #1, etc.
  syntax match AsanStack "#\d\+"

  " Hex memory addresses: 0x...
  syntax match AsanAddr "0x[0-9a-f]\{8,16\}"

  " File paths (rough match)
  syntax match AsanFile "[a-zA-Z0-9_/\.*+-]*:\d\+$"
endfunction

command! AsanHighlight call HighlightAsanLeakOutput()
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

vim.cmd([[
    if has("nvim")
      let $GIT_EDITOR = 'nvim --cmd "let g:unception_block_while_host_edits=1"'
    endif

    autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
]])
