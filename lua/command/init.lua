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
local autosave_debounce_ms = 10000

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

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function( --[[args]])
        -- Cancel existing timer if any
        if autosave_timer then
            autosave_timer:stop()
            autosave_timer = nil
        end
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

        -- Create new debounced timer
        autosave_timer = vim.defer_fn(function()
            autosave(args.buf)
            autosave_timer = nil
        end, autosave_debounce_ms)
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    callback = function()
        -- Save all modified buffers on exit
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted and vim.bo[bufnr].bufhidden == "" then
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

-- Build error quick jump in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function(args)
        vim.keymap.set("n", "gf", function()
            local line = vim.fn.getline(".")

            -- Try different error formats
            -- Format 1: file.cpp:123:45: error message
            local file, lnum, col = line:match("([^:%s]+):(%d+):(%d+):")

            -- Format 2: file.cpp:123: error message
            if not file then
                file, lnum = line:match("([^:%s]+):(%d+):")
            end

            -- Format 3: file.cpp(123): error message (MSVC style)
            if not file then
                file, lnum = line:match("([^%(]+)%((%d+)%):")
            end

            if file and lnum then
                -- Check if file exists
                if vim.fn.filereadable(file) == 1 then
                    vim.cmd.edit(file)
                    vim.fn.cursor(tonumber(lnum), tonumber(col) or 1)
                    vim.cmd.normal("zz") -- Center screen
                    vim.notify(string.format("Jumped to %s:%s", file, lnum), vim.log.levels.INFO)
                else
                    -- Try finding file in common build directories
                    local search_paths = {
                        vim.fn.getcwd() .. "/" .. file,
                        vim.fn.getcwd() .. "/src/" .. file,
                        vim.fn.getcwd() .. "/../src/" .. file,
                    }

                    for _, path in ipairs(search_paths) do
                        if vim.fn.filereadable(path) == 1 then
                            vim.cmd.edit(path)
                            vim.fn.cursor(tonumber(lnum), tonumber(col) or 1)
                            vim.cmd.normal("zz")
                            vim.notify(string.format("Jumped to %s:%s", path, lnum), vim.log.levels.INFO)
                            return
                        end
                    end

                    vim.notify(string.format("File not found: %s", file), vim.log.levels.WARN)
                end
            else
                -- Fallback to default gf behavior
                pcall(vim.cmd.normal, "gf")
            end
        end, { buffer = args.buf, desc = "Jump to error/file" })
    end,
})
