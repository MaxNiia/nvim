local M = {
	layout = {},
}

M.layout.lsp_layout = {
	horizontal = {
		preview_cutoff = 150,
		preview_width = 80,
		height = 0.9,
		width = 180,
	},
}

M.layout.small_cursor = {
	cursor = {
		preview_cutoff = 0,
		height = 10,
		width = 30,
		preview_width = 1,
	},
}

M.layout.center = {
	width = 120,
	height = 20,
	mirror = false,
	preview_cutoff = 0,
}

M.layout.cursor = {
	height = 40,
	width = 100,
	preview_cutoff = 0,
}

M.layout.horizontal = {
	preview_cutoff = 120,
	preview_width = 0.55,
	height = 24,
	-- width = 240,
}

M.layout.vertical = {
	height = 0.8,
	width = 120,
	preview_cutoff = 30,
	preview_height = 0.7,
	mirror = false,
}

M.layout.flex = {
	flip_columns = 240,
}

M.borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

return M
