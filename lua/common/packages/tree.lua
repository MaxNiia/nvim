require("nvim-tree").setup({
   view = {
      adaptive_size = true,
      relativenumber = true,
      number = true,
      mappings = {
         list = {
            {
               key = "<C-x>",
               action = "vsplit",
            },
         },
      },
   },
   renderer = {
      symlink_destination = false,
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
