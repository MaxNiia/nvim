local M = {}

function M.get_current_shada()
    local dir = vim.fn.expand(vim.fn.stdpath("state") .. "/shada/")
    vim.fn.mkdir(dir, "p")

    local pattern = "/"
    if vim.fn.has("win32") == 1 then
        pattern = "[\\:]"
    end

    local name = vim.fn.getcwd():gsub(pattern, "%%")
    return dir .. name .. ".shada"
end

return M
