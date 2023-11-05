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

			local wk = require("which-key")

			local function createCommand(method)
				return string.format(
					"<Cmd>lua require('nvim-magic.flows').%s(require('nvim-magic').backends.default)<CR>",
					method
				)
			end

			wk.register({
				m = {
					"+ChatGPT",
					a = {
						createCommand("append_completion"),
						"Completion",
					},
					s = {
						createCommand("suggest_alteration"),
						"Alteration",
					},
					d = {
						createCommand("suggest_docstring"),
						"Docstring",
					},
				},
			}, { prefix = "<leader>", mode = "v" })

			wk.register({
				m = {
					"+ChatGPT",
					c = {
						createCommand("suggest_chat"),
						"Chat",
					},
					r = {
						createCommand("suggest_chat_reset"),
						"Reset",
					},
				},
			}, { prefix = "<leader>", mode = "n" })
		end,
	},
}
