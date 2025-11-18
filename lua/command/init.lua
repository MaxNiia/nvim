local pack = require("command.pack")

vim.api.nvim_create_user_command("Pack", function(opts)
    pack.dispatch(opts)
end, {
    nargs = "*",
    complete = pack.complete,
    desc = "Pack command group (:Pack Update|Add|Remove ...)",
})

-- Autosave implementation with debounce for InsertLeave
local autosave_timer = nil

local function autosave(bufnr)
    -- Skip if buffer is not valid
    if not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end

    -- Only save normal buffers that are modified and have a name
    if
        vim.bo[bufnr].modified
        and vim.fn.bufname(bufnr) ~= ""
        and vim.bo[bufnr].buftype == ""
        and vim.bo[bufnr].modifiable
    then
        -- Use pcall to prevent errors from breaking the statusline
        local ok, err = pcall(vim.cmd, "silent! write")
        if not ok then
            vim.notify("Autosave failed: " .. tostring(err), vim.log.levels.WARN)
        end
    end
end

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*",
    callback = function(args)
        autosave(args.buf)
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function(args)
        -- Cancel existing timer if any
        if autosave_timer then
            autosave_timer:stop()
            autosave_timer = nil
        end

        -- Create new debounced timer (2 seconds)
        autosave_timer = vim.defer_fn(function()
            autosave(args.buf)
            autosave_timer = nil
        end, 2000)
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    callback = function()
        -- Save all modified buffers on exit
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(bufnr) then
                autosave(bufnr)
            end
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
