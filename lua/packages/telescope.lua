require("telescope").load_extension("aerial")

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("telescope").setup({
	extensions = {
		aerial = {
			show_nesting = {
				["_"] = false,
			},
		},
		fzf = {
			fuzzy = true,
			override_gneric_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
	defaults = {
		mappings = {
			i = {
				["<c-t>"] = trouble.open_with_trouble,
				["<C-h>"] = "which_key",
			},
			n = {
				["<c-t>"] = trouble.open_with_trouble,
			},
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("project")
require("telescope").load_extension("notify")
require("telescope").load_extension("noice")

local wk = require("which-key")
wk.register({
	f = {
		name = "Find",
		t = {
			"<cmd>Telescope<CR>",
			"Telescope",
		},
		f = {
			"<cmd>Telescope find_files<CR>",
			"Files",
		},
		b = {
			"<cmd>Telescope file_browser<CR>",
			"Browser",
		},
		o = {
			"<cmd>Telescope oldfiles<CR>",
			"Old files",
		},
		s = {
			"<cmd>Telescope live_grep<CR>",
			"Search",
		},
		d = {
			"<cmd>Telescope spell_suggest<CR>",
			"Dictionary",
		},
		p = {
			"<cmd>Telescope project<CR>",
			"Project",
		},
		n = {
			"<cmd>Telescope noice<CR>",
			"Noice",

		},
		m = {

			"<cmd>Telescope notify<CR>",
			"Notify",

		},
		g = {
			name = "Git",
			s = {
				"<cmd>Telescope git_status<CR>",
				"Git status",
			},
			b = {
				"<cmd>Telescope git_branches<CR>",
				"Git branches",
			},
			c = {
				"<cmd>Telescope git_commits<CR>",
				"Git commits",
			},
		},
		a = {
			"<cmd>Telescope aerial<CR>",
			"Aerial",
		},
	},
}, {
	prefix = "<leader>",
})
