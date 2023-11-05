return {
	"echasnovski/mini.files",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		-- Highlight Names
		-- vim.api.nvim_set_hl(0, "MiniFilesBorder", { link = "" })
		-- vim.api.nvim_set_hl(0, "MiniFilesBorderModified", { link = "" })
		-- vim.api.nvim_set_hl(0, "MiniFilesDirectory", { link = "" })
		-- vim.api.nvim_set_hl(0, "MiniFilesFile", { link = "" })
		-- vim.api.nvim_set_hl(0, "MiniFilesNormal", { link = "" })
		-- vim.api.nvim_set_hl(0, "MiniFilesTitle", { link = "" })
		-- vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { link = "" })

		-- Show dotfiles filter toggle.
		local show_dotfiles = false

		local filter_show = function(_)
			return true
		end

		local filter_hide = function(fs_entry)
			return not vim.startswith(fs_entry.name, ".")
		end

		local toggle_dotfiles = function()
			show_dotfiles = not show_dotfiles
			local new_filter = show_dotfiles and filter_show or filter_hide
			MiniFiles.refresh({ content = { filter = new_filter } })
		end

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id
				-- Tweak left-hand side of mapping to your liking
				vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
			end,
		})
	end,
	version = false,
	event = "BufEnter",
	keys = {
		{
			"<leader>e",
			"<cmd>lua MiniFiles.open(MiniFiles.get_latest_path())<cr>",
			desc = "Files",
			mode = "n",
		},
		{
			"<leader>EC",
			"<cmd>lua MiniFiles.open(nil, false)<cr>",
			desc = "CWD",
			mode = "n",
		},
		{
			"<leader>EB",
			"<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>",
			desc = "Buffer Dir",
			mode = "n",
		},
		{
			"<leader>EH",
			"<cmd>lua MiniFiles.open(vim.fn.expand('$HOME'))<cr>",
			desc = "Home",
			mode = "n",
		},
	},
	opts = {
		windows = {
			preview = true,
		},
		content = {
			filter = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end,
		},
	},
	config = function(_, opts)
		require("mini.files").setup(opts)
	end,
}
