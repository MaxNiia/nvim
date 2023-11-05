if IS_WINDOWS and not IS_WSL then
    return {}
end

local function homeFilePath()
	local home = ""
	if IS_WINDOWS and not IS_WSL then
		home = "$env:USERPROFILE" or ""
	elseif IS_LINUX or IS_WSL then
		home = os.getenv("HOME") or ""
	end
	return home .. "/.nvim.colorscheme-persist.lua"
end

return {
	{
		"propet/colorscheme-persist.nvim",
		dependencies = {
			"catppuccin/nvim",
			"EdenEast/nightfox.nvim",
		},
		event = "VimEnter",
		keys = {
			{
				"<leader>fc",
				function()
					require("colorscheme-persist").picker()
				end,
				desc = "Colorscheme",
			},
		},
		opts = {
			-- Absolute path to file where colorscheme should be saved
			file_path = homeFilePath(),
			-- In case there's no saved colorscheme yet
			fallback = "catppuccin-mocha", -- "catppuccin-mocha",
			-- List of ugly colorschemes to avoid in the selection window
			disable = {
				"darkblue",
				"default",
				"delek",
				"desert",
				"elflord",
				"evening",
				"industry",
				"koehler",
				"morning",
				"murphy",
				"pablo",
				"peachpuff",
				"ron",
				"shine",
				"slate",
				"torte",
				"zellner",
			},
			-- Options for the telescope picker
			picker_opts = {
				initial_mode = "insert",
				layout_strategy = "cursor",
				layout_config = {
					cursor = {
						preview_cutoff = 0,
						height = 10,
						width = 30,
						preview_width = 1,
					},
				},
				preview_cutoff = 0,
				enable_preview = true,
			},
		},
		config = function(_, opts)
			local persist_colorscheme = require("colorscheme-persist")

			-- Setup
			persist_colorscheme.setup(opts)

			-- Get stored colorscheme
			local colorscheme = persist_colorscheme.get_colorscheme()

			-- Set colorscheme
			vim.cmd.colorscheme(colorscheme)

			require("lualine")
			require("lsp-inlayhints")
			require("telescope")
		end,
	},
}
