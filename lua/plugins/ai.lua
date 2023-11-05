--[[
This module configures the nvim-magic plugin for Neovim.

It sets up the OpenAI backend with a custom API endpoint,
disables the default keymap, and registers custom keybindings
for various nvim-magic actions.

Dependencies:
    - ricardicus/nvim-magic
    - nvim-lua/plenary.nvim
    - MunifTanjim/nui.nvim

Keybindings:
    - Visual mode:
        - <leader>ma: Append completion
        - <leader>ms: Suggest alteration
        - <leader>md: Suggest docstring
    - Normal mode:
        - <leader>mc: Suggest chat
        - <leader>mr: Reset chat

Returns:
    A table containing the plugin configuration.

Raises:
    None
]]
return {
	{
		"ricardicus/nvim-magic",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function(_, _)
			local backend_url = require("configs.ai_backend")

			require("nvim-magic").setup({
				backends = {
					default = require("nvim-magic-openai").new({
						api_endpoint = backend_url,
					}),
				},
				use_default_keymap = false,
			})

		end,
	},
}
