local pack = require("command.pack")

vim.api.nvim_create_user_command("Pack", function(opts)
    pack.dispatch(opts)
end, {
    nargs = "*",
    complete = pack.complete,
    desc = "Pack command group (:Pack Update|Add|Remove ...)",
})

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*",
    callback = function()
        if vim.bo.modified and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
            vim.cmd("silent write")
        end
    end,
})

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

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
]])
