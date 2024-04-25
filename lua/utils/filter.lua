--- Checks if a buffer has active errors.
---@param bufnr integer|nil to check for errors
---@return boolean true if buffer has errors, false otherwise
local has_errors = function(bufnr)
    if vim.diagnostic then
        local diagnostics = vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
        if #diagnostics > 0 then
            return true
        end
    end
    return false
end

--- Checks if a buffer is loaded.
---@param bufnr integer to check if loaded
---@return boolean true if buffer is loaded, false otherwise
local loaded = function(bufnr)
    return vim.api.nvim_buf_is_loaded(bufnr)
end

local modifiable = function(bufnr)
    return vim.fn.getbufvar(bufnr, "&modifiable") == 1
end

local is_filetype = function(bufnr)
    local filetypes = {
        "alpha",
        "TelescopePrompt",
        "minifiles",
        "ToggleTerm",
        "Spectre",
    }

    local utils = require("auto-save.utils.data")
    if utils.not_in(vim.fn.getbufvar(bufnr, "&filetype"), filetypes) then
        return true
    end
    return false
end

local saveable = function(bufnr)
    local filters = {
        active = {
            loaded,
            modifiable,
        },
        inactive = {
            is_filetype,
            has_errors,
        },
    }

    local saveable = true
    for _, filter in pairs(filters.active) do
        saveable = saveable and filter(bufnr)
        if not saveable then
            return false
        end
    end
    for _, filter in pairs(filters.inactive) do
        saveable = saveable and not filter(bufnr)
        if not saveable then
            return false
        end
    end

    return saveable
end

return {
    has_errors = has_errors,
    is_filetype = is_filetype,
    loaded = loaded,
    modifiable = modifiable,
    saveable = saveable,
}
