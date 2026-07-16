local key = vim.keymap.set

local function fzf_open(cmd, on_select)
    local tmpfile = vim.fn.tempname()
    local height = math.floor(vim.o.lines * 0.4)
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        row = vim.o.lines - height - 3,
        col = 0,
        width = vim.o.columns,
        height = height,
        style = "minimal",
        border = "rounded",
    })
    vim.fn.termopen({ "sh", "-c", cmd .. " > " .. tmpfile }, {
        on_exit = function()
            vim.schedule(function()
                pcall(vim.api.nvim_win_close, win, true)
                local ok, lines = pcall(vim.fn.readfile, tmpfile)
                vim.fn.delete(tmpfile)
                if not ok or #lines == 0 then return end
                on_select(lines[1])
            end)
        end,
    })
    vim.cmd.startinsert()
end

local function fd_fzf()
    fzf_open("fd --type f | fzf", function(sel)
        vim.cmd.edit(vim.trim(sel))
    end)
end

local function rg_fzf()
    local rg = "rg --column --line-number --no-heading --color=always --smart-case"
    local cmd = string.format(
        "%s '' | fzf --ansi --bind 'change:reload:%s {q} 2>/dev/null || true'",
        rg, rg
    )
    fzf_open(cmd, function(sel)
        local fname, lnum, col = sel:match("^(.+):(%d+):(%d+):")
        if not fname then return end
        vim.cmd.edit(fname)
        vim.api.nvim_win_set_cursor(0, { tonumber(lnum), tonumber(col) - 1 })
    end)
end

key("n", "<leader>ff", fd_fzf, { desc = "fd files (fzf)" })
key("n", "<leader>fg", rg_fzf, { desc = "rg live grep (fzf)" })
