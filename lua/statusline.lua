local M = {}

local function stl_hl(name)
    return string.format("%%#%s#", name)
end

local space = " "
local double_space = "  "

function M.directory()
    if vim.v.virtnum ~= 0 then
        return double_space
    end

    local name = vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, true)[1]

    local mini_icons = require("mini.icons")
    local icon, icon_hl
    if name:sub(-1) == "/" then
        icon, icon_hl = mini_icons.get("directory", name:sub(1, -2))
    else
        icon, icon_hl = mini_icons.get("file", name)
    end

    return table.concat({
        stl_hl(icon_hl),
        icon,
        space,
    })
end

return M
