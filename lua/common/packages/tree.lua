require("nvim-tree").setup({
   view = {
	adaptive_size = true,
	relativenumber = true,
	number = true,
   },
})

local wk = require("which-key")
wk.register({
	["<leader>e"] = {
		"<cmd>NvimTreeToggle<CR>",
		"Explorer",
	},
}, {
})
