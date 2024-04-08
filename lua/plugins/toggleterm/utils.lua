local M = {}

M.toggleTerminal = function(direction)
    return function()
        local term_number = vim.v.count
        return "<cmd>" .. tostring(term_number) .. "ToggleTerm direction=" .. direction .. "<cr>"
    end
end

return M
