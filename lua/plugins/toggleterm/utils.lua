local M = {}

M.toggleTerminal = function(direction)
    return function()
        local tab_nr = vim.api.nvim_tabpage_get_number(0)
        local term_number = tab_nr + vim.v.count
        return "<cmd>" .. tostring(term_number) .. "ToggleTerm direction=" .. direction .. "<cr>"
    end
end

return M
