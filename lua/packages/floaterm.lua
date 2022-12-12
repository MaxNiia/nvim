local wk = require("which-key")
wk.register({
	t = {
		"<cmd>FloatermToggle<CR>",
		"Terminal",
	},
}, {
	prefix = "<leader>",
})

wk.register({
   ["<esc>"] = {
		"<cmd>FloatermToggle<CR>",
		"Terminal",
	},
}, {
	prefix = "<leader>",
   mode = "t",
})
