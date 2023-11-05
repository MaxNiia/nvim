require("nvim-tree").setup()

local wk = require("which-key")
wk.register({
	["<leader>e"] = {
		"<cmd>NvimTreeToggle<CR>",
		"Explorer",
	},
}, {
})
