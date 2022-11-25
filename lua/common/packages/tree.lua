require("nvim-tree").setup({
   view = {
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
