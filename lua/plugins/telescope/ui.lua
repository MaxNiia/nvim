local M = {
    layouts = {},
}

M.layouts.lsp = {
    horizontal = {
        preview_cutoff = 150,
        preview_width = 100,
        height = 0.9,
        width = 180,
    },
    vertical = {
        height = 0.8,
        width = 160,
        preview_cutoff = 30,
        preview_height = 0.7,
        mirror = false,
    },
}

M.layouts.small_cursor = {
    cursor = {
        preview_cutoff = 0,
        height = 10,
        width = 30,
        preview_width = 0,
    },
}

M.layouts.center = {
    width = 120,
    height = 20,
    mirror = false,
    preview_cutoff = 0,
}

M.layouts.cursor = {
    height = 40,
    width = 100,
    preview_cutoff = 0,
}

M.layouts.horizontal = {
    preview_cutoff = 120,
    preview_width = 0.55,
    height = 24,
    -- width = 240,
}

M.layouts.vertical = {
    height = 0.8,
    width = 120,
    preview_cutoff = 30,
    preview_height = 0.7,
    mirror = false,
}

M.layouts.flex = {
    flip_columns = 240,
}

M.borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

return M
