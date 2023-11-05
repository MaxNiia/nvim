local backend_url = require("configs.ai_backend")

return {
	{
		"ricardicus/nvim-magic",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function(_, _)
			require("nvim-magic").setup({
				backends = {
					default = require("nvim-magic-openai").new({
						api_endpoint = backend_url,
					}),
				},
			})
		end,
	},
}
