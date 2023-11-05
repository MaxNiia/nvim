--[[
This module configures the nvim-magic plugin for Neovim.

It sets up the OpenAI backend with a custom API endpoint, disables the default keymap, and registers custom keybindings for various nvim-magic actions.

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

			local wk = require("which-key")

			wk.register({
				m = {
					"+ChatGPT",
					a = {
						"<Cmd>lua require('nvim-magic.flows').append_completion(require('nvim-magic').backends.default)<CR>",
						"Completion",
					},
					s = {
						"<Cmd>lua require('nvim-magic.flows').suggest_alteration(require('nvim-magic').backends.default)<CR>",
						"Completion",
					},
					d = {
						"<Cmd>lua require('nvim-magic.flows').suggest_docstring(require('nvim-magic').backends.default)<CR>",
						"Docstring",
					},
				},
			}, { prefix = "<leader>", mode = "v" })

			wk.register({
				m = {
					"+ChatGPT",
					c = {
						"<Cmd>lua require('nvim-magic.flows').suggest_chat(require('nvim-magic').backends.default)<CR>",
						"Chat",
					},
					r = {
						"<Cmd>lua require('nvim-magic.flows').suggest_chat_reset(require('nvim-magic').backends.default)<CR>",
						"Reset",
					},
				},
			}, { prefix = "<leader>", mode = "n" })
		end,
	},
}
