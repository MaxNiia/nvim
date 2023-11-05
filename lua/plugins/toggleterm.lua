local function toggleTerminal(direction)
	return function()
		return "<cmd>" .. tostring(vim.v.count) .. "ToggleTerm direction=" .. direction .. "<cr>"
	end
end

return {
	{
		"akinsho/toggleterm.nvim",
		dependencies = {
			"samjwill/nvim-unception",
			init = function()
				-- Optional settings go here!
				vim.g.unception_delete_replaced_buffer = false
				vim.g.unception_open_buffer_in_new_tab = true
				vim.g.unception_enable_flavor_text = true

				vim.api.nvim_create_autocmd("User", {
					pattern = "UnceptionEditRequestReceived",
					callback = function()
						-- Toggle the terminal off.
						if vim.bo.filetype == "toggleterm" then
							require("toggleterm").toggle_all(true)
						end
					end,
				})
			end,
		},
		event = "BufEnter",
		keys = {
			{ "<leader>tl", "<cmd>ToggleTermSendCurrentLine<CR>", desc = "Send line" },
			{ "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", desc = "Toggle all terminals" },
			{
				"<leader>th",
				toggleTerminal("horizontal"),
				desc = "Toggle horizontal",
				expr = true,
			},
			{
				"<leader>tv",
				toggleTerminal("vertical"),
				desc = "Toggle vertical",
				expr = true,
			},
			{
				"<leader>tf",
				toggleTerminal("float"),
				desc = "Toggle float",
				expr = true,
			},
			{
				"<f5>",
				toggleTerminal("horizontal"),
				desc = "Toggle horizontal",
				expr = true,
			},
			{
				"<f6>",
				toggleTerminal("vertical"),
				desc = "Toggle vertical",
				expr = true,
			},
			{
				"<f7>",
				toggleTerminal("float"),
				desc = "Toggle float",
				expr = true,
			},
			{ "<f8>", "<cmd>ToggleTermToggleAll<CR>", desc = "Toggle all terminals" },
		},
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 10
				elseif term.direction == "vertical" then
					return math.min(vim.o.columns * 0.25, 100)
				end
				return 20
			end,
			on_create = function(terminal)
				terminal.name = terminal.count
			end,
			open_mapping = "<f12>",
			hide_number = true,
			autochdir = true,
			shade_terminals = false,
			start_in_insert = true,
			terminal_mappings = true,
			-- persist_size = true,
			persist_mode = true,
			direction = "vertical", --| "horizontal" | "tab" | "float",
			close_on_exit = false,
			shell = vim.o.shell,
			auto_scroll = true,
			float_opts = {
				border = "curved",
				width = 100,
				height = 40,
				winblend = 3,
			},
			winbar = {
				enabled = false,
				name_formatter = function(term) --  term: Terminal
					return term.name
				end,
			},
		},
	},
}
