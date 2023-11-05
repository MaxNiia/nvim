local lsp_layout = {
	horizontal = {
		preview_cutoff = 150,
		preview_width = 80,
		height = 0.9,
		width = 180,
	},
}

local small_cursor = {
	cursor = {
		preview_cutoff = 0,
		height = 10,
		width = 30,
		preview_width = 1,
	},
}

local root_patterns = { ".git", "lua" }
-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
local function get_root()
	---@type string?
	local path = vim.api.nvim_buf_get_name(0)
	path = path ~= "" and vim.loop.fs_realpath(path) or nil
	---@type string[]
	local roots = {}
	if path then
		for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			local workspace = client.config.workspace_folders
			local paths = workspace and vim.tbl_map(function(ws)
				return vim.uri_to_fname(ws.uri)
			end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
			for _, p in ipairs(paths) do
				local r = vim.loop.fs_realpath(p)
				if path:find(r, 1, true) then
					roots[#roots + 1] = r
				end
			end
		end
	end
	table.sort(roots, function(a, b)
		return #a > #b
	end)
	---@type string?
	local root = roots[1]
	if not root then
		path = path and vim.fs.dirname(path) or vim.loop.cwd()
		---@type string?
		root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
		root = root and vim.fs.dirname(root) or vim.loop.cwd()
	end
	---@cast root string
	return root
end

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
local function callTelescope(builtin, opts)
	local params = { builtin = builtin, opts = opts }
	return function()
		builtin = params.builtin
		opts = params.opts
		opts = vim.tbl_deep_extend("force", { cwd = get_root() }, opts or {})
		if builtin == "files" then
			builtin = "find_files"
			if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
				opts.show_untracked = true
				builtin = "git_files"
			else
				builtin = "find_files"
			end
		end
		if opts.cwd and opts.cwd ~= vim.loop.cwd() then
			opts.attach_mappings = function(_, map)
				map("i", "<a-c>", function()
					local action_state = require("telescope.actions.state")
					local line = action_state.get_current_line()
					callTelescope(
						params.builtin,
						vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
					)()
				end)
				return true
			end
		end

		require("telescope.builtin")[builtin](opts)
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			-- LEADER f
			{
				"<leader>fj",
				"<cmd>Telescope grep_string<cr>",
				desc = "Grep string (root)",
				mode = {
					"v",
					"n",
				},
			},
			{
				"<leader>fJ",
				callTelescope("grep_string"),
				desc = "Grep string (cwd)",
				mode = {
					"v",
					"n",
				},
			},
			{ "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{ "<leader>ft", "<cmd>Telescope<cr>", desc = "Telescope" },
			{ "<leader>ff", callTelescope("files"), desc = "Files (root)" },
			{ "<leader>fF", callTelescope("files", { cwd = false }), desc = "Files (cwd)" },
			{ "<leader>fs", callTelescope("live_grep"), desc = "Search (root dir)" },
			{ "<leader>fS", callTelescope("live_grep", { cwd = false }), desc = "Search (cwd)" },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Old files (root)" },
			{ "<leader>fO", callTelescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Old files (cwd)" },
			{ "<leader>fq", "<cmd>Telescope spell_suggest<CR>", desc = "Dictionary" },
			{ "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Project" },
			{ "<leader>fn", "<cmd>Telescope noice<CR>", desc = "Noice" },
			{ "<leader>fN", "<cmd>Telescope notify<CR>", desc = "Notify" },
			{ "<leader>fm", "<cmd>Telescope man_pages<CR>", desc = "Man pages" },
			{ "<leader>fa", "<cmd>Telescope aerial<CR>", desc = "Aerial" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },

			-- Session
			{ "<leader>fws", "<cmd>SessionLoad<cr>", desc = "Restore directory session" },
			{ "<leader>fwl", "<cmd>SessionLoadLast<cr>", desc = "Restore last session" },
			{ "<leader>fwd", "<cmd>SessionStop<cr>", desc = "Don't save" },

			-- GIT
			{ "<leader>fgs", "<cmd>Telescope git_status<CR>", desc = "Status" },
			{ "<leader>fgb", "<cmd>Telescope git_branches<CR>", desc = "Branches" },
			{ "<leader>fgc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },

			-- DAP
			{ "<leader>fdc", "<cmd>Telescope dap commands<CR>", desc = "Commands" },
			{ "<leader>fdb", "<cmd>Telescope dap list_breakpoints<CR>", desc = "Breakpoints" },
			{ "<leader>fdv", "<cmd>Telescope dap variables<CR>", desc = "Variables" },
			{ "<leader>fdf", "<cmd>Telescope dap frames<CR>", desc = "Frames" },
			{ "<leader>fdx", "<cmd>Telescope dap configurations<CR>", desc = "Configurations" },

			-- LSP
			{ "<leader>flr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "<leader>fli", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Incoming" },
			{ "<leader>flo", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "Outgoing" },
			{ "<leader>fld", "<cmd>Telescope lsp_definitions<cr>", desc = "Definitions" },
			{ "<leader>flt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions" },
			{ "<leader>flj", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
			{
				"<leader>fls",
				callTelescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
			},
			{
				"<leader>fJ",
				callTelescope("grep_string"),
				desc = "Grep string (cwd)",
				mode = {
					"v",
					"n",
				},
			},
			{ "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{ "<leader>ft", "<cmd>Telescope<cr>", desc = "Telescope" },
			{ "<leader>ff", callTelescope("files"), desc = "Files (root)" },
			{ "<leader>fF", callTelescope("files", { cwd = false }), desc = "Files (cwd)" },
			{ "<leader>fs", callTelescope("live_grep"), desc = "Search (root dir)" },
			{ "<leader>fS", callTelescope("live_grep", { cwd = false }), desc = "Search (cwd)" },
			{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Old files (root)" },
			{ "<leader>fO", callTelescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Old files (cwd)" },
			{ "<leader>fq", "<cmd>Telescope spell_suggest<CR>", desc = "Dictionary" },
			{ "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Project" },
			{ "<leader>fn", "<cmd>Telescope noice<CR>", desc = "Noice" },
			{ "<leader>fN", "<cmd>Telescope notify<CR>", desc = "Notify" },
			{ "<leader>fm", "<cmd>Telescope manpages<CR>", desc = "Manpages" },
			{ "<leader>fa", "<cmd>Telescope aerial<CR>", desc = "Aerial" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },

			-- Session
			{ "<leader>fws", "<cmd>SessionLoad<cr>", desc = "Restore directory session" },
			{ "<leader>fwl", "<cmd>SessionLoadLast<cr>", desc = "Restore last session" },
			{ "<leader>fwd", "<cmd>SessionStop<cr>", desc = "Don't save" },

			-- GIT
			{ "<leader>fgs", "<cmd>Telescope git_status<CR>", desc = "Status" },
			{ "<leader>fgb", "<cmd>Telescope git_branches<CR>", desc = "Branches" },
			{ "<leader>fgc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },

			-- DAP
			{ "<leader>fdc", "<cmd>Telescope dap commands<CR>", desc = "Commands" },
			{ "<leader>fdb", "<cmd>Telescope dap list_breakpoints<CR>", desc = "Breakpoints" },
			{ "<leader>fdv", "<cmd>Telescope dap variables<CR>", desc = "Variables" },
			{ "<leader>fdf", "<cmd>Telescope dap frames<CR>", desc = "Frames" },
			{ "<leader>fdx", "<cmd>Telescope dap configurations<CR>", desc = "Configurations" },

			-- LSP
			{ "<leader>flr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "<leader>fli", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Incoming" },
			{ "<leader>flo", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "Outgoing" },
			{ "<leader>fld", "<cmd>Telescope lsp_definitions<cr>", desc = "Definitions" },
			{ "<leader>flt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions" },
			{ "<leader>flj", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
			{
				"<leader>fls",
				callTelescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol",
			},
			{
				"<leader>flS",
				callTelescope("lsp_dynamic_workspace_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol (WS)",
			},

			-- LEADER
			{
				"<leader>s",
				"<cmd>Telescope grep_string<cr>",
				desc = "Grep string (root)",
				mode = {
					"v",
					"n",
				},
			},
			{
				"<leader>S",
				callTelescope("grep_string"),
				desc = "Grep string (cwd)",
				mode = {
					"v",
					"n",
				},
			},
			{ "<leader>e", "<cmd>Telescope file_browser<CR>", desc = "Browser (root)" },
			{ "<leader>E", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "Browser (cwd)" },
			{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch buffers" },
			{ "<leader>/", callTelescope("live_grep"), desc = "Search (root)" },
			{ "<leader>?", callTelescope("live_grep", { cwd = false }), desc = "Search (cwd)" },
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		},
		dependencies = {
			{
				"MaxNiia/telescope-fzf-native.nvim",
				build = "make",
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
			{
				"olimorris/persisted.nvim",
				opts = {
					use_git_branch = true,
					PersistedTelescopeLoadPre = function()
						vim.api.nvim_input("<ESC>:%bd<CR>")
					end,
					PersistedTelescopeLoadPost = function(session)
						print("Loaded session " .. session.name)
					end,
					picker_opts = {
						initial_mode = "normal",
						layout_strategy = "cursor",
						layout_config = small_cursor,
						enable_preview = true,
					},
				},
				config = function(_, opts)
					require("persisted").setup(opts)
				end,
			},
			"nvim-telescope/telescope-dap.nvim",
			"mfussenegger/nvim-dap",
		},
		lazy = true,
		opts = {
			pickers = {
				colorscheme = {
					initial_mode = "normal",
					layout_strategy = "cursor",
					layout_config = small_cursor,
					enable_preview = true,
				},
				live_grep = {},
				grep_strings = {
					initial_mode = "normal",
					layout_config = {
						horizontal = {
							preview_cutoff = 150,
							preview_width = 80,
							height = 0.9,
							width = 180,
						},
					},
				},
				spell_suggest = {
					initial_mode = "normal",
					layout_strategy = "cursor",
					layout_config = small_cursor,
				},
				lsp_references = {
					layout_config = lsp_layout,
				},
				lsp_incoming_calls = {
					layout_config = lsp_layout,
				},
				lsp_outgoing_calls = {
					layout_config = lsp_layout,
				},
				lsp_definitions = {
					layout_config = lsp_layout,
				},
				lsp_type_definitions = {
					layout_config = lsp_layout,
				},
				lsp_implementations = {
					layout_config = lsp_layout,
				},
				lsp_document_symbols = {
					layout_config = lsp_layout,
				},
				lsp_workspace_symbols = {
					layout_config = lsp_layout,
				},
				lsp_dynamic_workspace_symbols = {
					layout_config = lsp_layout,
				},
				diagnostics = {
					layout_config = lsp_layout,
				},
			},
			extensions = {
				file_browser = {
					hijack_netrw = true,
					display_stat = false,
					initial_mode = "normal",
				},
				aerial = {
					show_nesting = {
						["_"] = false,
					},
				},
				fzf = {
					fuzzy = true,
					override_gneric_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
			defaults = {
				vimgrep_arguments = {
					"rg",
					"-L",
					"-S",
					"--color=never",
					"--column",
					"--line-number",
					"--no-heading",
					"--with-filename",
				},
				prompt_prefix = "   ",
				border = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				color_devicons = true,
				--	{ "─", "│", "─", "│", "┌", "┐", "┘", "└" }, Standard
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				-- prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				-- results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				-- preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				winblend = 0,
				wrap_results = false,
				path_display = { truncate = 1 },
				selection_caret = "",
				entry_prefix = " ",
				initial_mode = "insert",
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				file_ignore_patterns = { "node_modules" },
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				prompt_title = "",
				results_title = "",
				preview_title = "",
				layout_strategy = "vertical",
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
				},
				layout_config = {
					prompt_position = "top",
					width = 0.87,
					height = 0.80,
					center = {
						width = 120,
						height = 20,
						mirror = false,
						preview_cutoff = 0,
					},
					cursor = {
						height = 40,
						width = 100,
						preview_cutoff = 0,
					},
					horizontal = {
						preview_cutoff = 120,
						preview_width = 0.55,
						height = 24,
						-- width = 240,
					},
					vertical = {
						height = 0.8,
						width = 120,
						preview_cutoff = 30,
						preview_height = 0.7,
						mirror = false,
					},
					flex = {
						flip_columns = 240,
					},
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)

			require("telescope.actions")
			local trouble = require("trouble.providers.telescope")

			require("telescope").load_extension("aerial")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("projects")
			require("telescope").load_extension("notify")
			require("telescope").load_extension("persisted")
			require("telescope").load_extension("noice")
			require("telescope").load_extension("dap")

			telescope.setup({
				defaults = {
					mappings = {
						i = { ["<c-t>"] = trouble.open_with_trouble },
						n = { ["<c-t>"] = trouble.open_with_trouble },
					},
				},
			})
		end,
	},
}
