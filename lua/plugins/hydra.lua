return {
	{
		"anuvyklack/hydra.nvim",
		dependencies = {
			"jbyuki/venn.nvim",
		},
		event = "BufEnter",
		config = function(_, _)
			local hydra = require("hydra")

			hydra(require("plugins.hydras.venn"))
			hydra(require("plugins.hydras.options"))
		end,
	},
}
