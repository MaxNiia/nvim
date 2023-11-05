return {
	{
		"kazhala/close-buffers.nvim",
		dependencies = {
			"folke/which-key.nvim",
		},
		event = "VimEnter",
		opts = {
			filetype_ignore = require("utils.exlude_files"),
			preserve_window_layout = {
				"this",
				"nameless",
			},
		},
		config = true,
	},
}
