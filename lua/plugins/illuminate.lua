return {
	{
		"RRethy/vim-illuminate",
		config = function(_, _)
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				delay = 100,
			})
		end,
	},
}
