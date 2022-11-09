require("telescope").load_extension("aerial")

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("telescope").setup({
	defaults = {
		i = {
			["<C-h>"] = "which_key",
		},
	},
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
				["<c-t>"] = trouble.open_with_trouble 
			},
			n = { 
				["<c-t>"] = trouble.open_with_trouble 
			},
		},
	},
})

require("telescope").load_extension('fzf')

local wk = require("which-key")
wk.register({
	f = {
		name = "Find",
		t = {
			"<cmd>Telescope<CR>",
			"Telescope"
		},
      f = {
         "<cmd>Telescope find_files<CR>",
         "Files",
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
			b = {
				"<cmd>Telescope git_bcommits<CR>",
				"Git buffer commits",
			},
		},
		a = {
			"<cmd>Telescope aerial<CR>",
			"Aerial",
		},
	},
}, {
	prefix = "<leader>"
})

