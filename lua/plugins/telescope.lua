local utils = require("utils.telescope")
local call_telescope = utils.call_telescope

return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			-- LEADER r
			{
				"<leader>rr",
				"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
				desc = "Refactor Telescope",
				mode = "v",
			},
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
				call_telescope("grep_string"),
				desc = "Grep string (cwd)",
				mode = {
					"v",
					"n",
				},
			},
			{ "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{
				"<leader>ft",
				"<cmd>Telescope<cr>",
				desc = "Telescope",
			},
			{
				"<leader>ff",
				call_telescope("files"),
				desc = "Files (root)",
			},
			{
				"<leader>fG",
				call_telescope("git_files"),
				desc = "Files (git)",
			},
			{
				"<leader>fF",
				call_telescope("files", { cwd = false }),
				desc = "Files (cwd)",
			},
			{
				"<leader>fs",
				call_telescope("live_grep"),
				desc = "Search (root dir)",
			},
			{
				"<leader>fS",
				call_telescope("live_grep", { cwd = false }),
				desc = "Search (cwd)",
			},
			{
				"<leader>fb",
				"<cmd>Telescope buffers<CR>",
				desc = "Buffers",
			},
			{
				"<leader>fo",
				"<cmd>Telescope oldfiles<CR>",
				desc = "Old files (root)",
			},
			{
				"<leader>fO",
				call_telescope("oldfiles", { cwd = vim.loop.cwd() }),
				desc = "Old files (cwd)",
			},
			{
				"<leader>fq",
				"<cmd>Telescope spell_suggest<CR>",
				desc = "Dictionary",
			},
			{
				"<leader>fp",
				"<cmd>Telescope projects<CR>",
				desc = "Project",
			},
			{ "<leader>fn", "<cmd>Telescope noice<CR>", desc = "Noice" },
			{ "<leader>fN", "<cmd>Telescope notify<CR>", desc = "Notify" },
			{
				"<leader>fm",
				"<cmd>Telescope man_pages<CR>",
				desc = "Man pages",
			},
			{ "<leader>fa", "<cmd>Telescope aerial<CR>", desc = "Aerial" },
			{
				"<leader>fk",
				"<cmd>Telescope keymaps<cr>",
				desc = "Key Maps",
			},

			-- Session
			{
				"<leader>fws",
				"<cmd>SessionLoad<cr>",
				desc = "Restore directory session",
			},
			{
				"<leader>fwl",
				"<cmd>SessionLoadLast<cr>",
				desc = "Restore last session",
			},
			{
				"<leader>fwd",
				"<cmd>SessionStop<cr>",
				desc = "Don't save",
			},

			-- GIT
			{ "<leader>fgs", "<cmd>Telescope git_status<CR>", desc = "Status" },
			{
				"<leader>fgb",
				"<cmd>Telescope git_branches<CR>",
				desc = "Branches",
			},
			{
				"<leader>fgc",
				"<cmd>Telescope git_commits<CR>",
				desc = "Commits",
			},

			-- DAP
			{
				"<leader>fdc",
				"<cmd>Telescope dap commands<CR>",
				desc = "Commands",
			},
			{
				"<leader>fdb",
				"<cmd>Telescope dap list_breakpoints<CR>",
				desc = "Breakpoints",
			},
			{
				"<leader>fdv",
				"<cmd>Telescope dap variables<CR>",
				desc = "Variables",
			},
			{ "<leader>fdf", "<cmd>Telescope dap frames<CR>", desc = "Frames" },
			{
				"<leader>fdx",
				"<cmd>Telescope dap configurations<CR>",
				desc = "Configurations",
			},

			-- LSP
			{
				"<leader>flr",
				"<cmd>Telescope lsp_references<cr>",
				desc = "References",
			},
			{
				"<leader>fli",
				"<cmd>Telescope lsp_incoming_calls<cr>",
				desc = "Incoming",
			},
			{
				"<leader>flo",
				"<cmd>Telescope lsp_outgoing_calls<cr>",
				desc = "Outgoing",
			},
			{
				"<leader>fld",
				"<cmd>Telescope lsp_definitions<cr>",
				desc = "Definitions",
			},
			{
				"<leader>flt",
				"<cmd>Telescope lsp_type_definitions<cr>",
				desc = "Type Definitions",
			},
			{
				"<leader>flj",
				"<cmd>Telescope lsp_implementations<cr>",
				desc = "Implementations",
			},
			{
				"<leader>fls",
				call_telescope("lsp_document_symbols", {
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
				call_telescope("grep_string"),
				desc = "Grep string (cwd)",
				mode = {
					"v",
					"n",
				},
			},
			{ "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{
				"<leader>ft",
				"<cmd>Telescope<cr>",
				desc = "Telescope",
			},
			{
				"<leader>ff",
				call_telescope("files"),
				desc = "Files (root)",
			},
			{
				"<leader>fF",
				call_telescope("files", { cwd = false }),
				desc = "Files (cwd)",
			},
			{
				"<leader>fs",
				call_telescope("live_grep"),
				desc = "Search (root dir)",
			},
			{
				"<leader>fS",
				call_telescope("live_grep", { cwd = false }),
				desc = "Search (cwd)",
			},
			{
				"<leader>fb",
				"<cmd>Telescope buffers<CR>",
				desc = "Buffers",
			},
			{
				"<leader>fo",
				"<cmd>Telescope oldfiles<CR>",
				desc = "Old files (root)",
			},
			{
				"<leader>fO",
				call_telescope("oldfiles", { cwd = vim.loop.cwd() }),
				desc = "Old files (cwd)",
			},
			{
				"<leader>fq",
				"<cmd>Telescope spell_suggest<CR>",
				desc = "Dictionary",
			},
			{
				"<leader>fp",
				"<cmd>Telescope projects<CR>",
				desc = "Project",
			},
			{ "<leader>fn", "<cmd>Telescope noice<CR>", desc = "Noice" },
			{ "<leader>fN", "<cmd>Telescope notify<CR>", desc = "Notify" },
			{
				"<leader>fm",
				"<cmd>Telescope manpages<CR>",
				desc = "Manpages",
			},
			{ "<leader>fa", "<cmd>Telescope aerial<CR>", desc = "Aerial" },
			{
				"<leader>fk",
				"<cmd>Telescope keymaps<cr>",
				desc = "Key Maps",
			},

			-- Session
			{
				"<leader>fws",
				"<cmd>SessionLoad<cr>",
				desc = "Restore directory session",
			},
			{
				"<leader>fwl",
				"<cmd>SessionLoadLast<cr>",
				desc = "Restore last session",
			},
			{
				"<leader>fwd",
				"<cmd>SessionStop<cr>",
				desc = "Don't save",
			},

			-- GIT
			{ "<leader>fgs", "<cmd>Telescope git_status<CR>", desc = "Status" },
			{
				"<leader>fgb",
				"<cmd>Telescope git_branches<CR>",
				desc = "Branches",
			},
			{
				"<leader>fgc",
				"<cmd>Telescope git_commits<CR>",
				desc = "Commits",
			},

			-- Harpoon
			{
				"<leader>fh",
				"<cmd>Telescope harpoon marks<CR>",
				desc = "Harpoon",
			},

			-- DAP
			{
				"<leader>fdc",
				"<cmd>Telescope dap commands<CR>",
				desc = "Commands",
			},
			{
				"<leader>fdb",
				"<cmd>Telescope dap list_breakpoints<CR>",
				desc = "Breakpoints",
			},
			{
				"<leader>fdv",
				"<cmd>Telescope dap variables<CR>",
				desc = "Variables",
			},
			{ "<leader>fdf", "<cmd>Telescope dap frames<CR>", desc = "Frames" },
			{
				"<leader>fdx",
				"<cmd>Telescope dap configurations<CR>",
				desc = "Configurations",
			},

			-- LSP
			{
				"<leader>flr",
				"<cmd>Telescope lsp_references<cr>",
				desc = "References",
			},
			{
				"<leader>fli",
				"<cmd>Telescope lsp_incoming_calls<cr>",
				desc = "Incoming",
			},
			{
				"<leader>flo",
				"<cmd>Telescope lsp_outgoing_calls<cr>",
				desc = "Outgoing",
			},
			{
				"<leader>fld",
				"<cmd>Telescope lsp_definitions<cr>",
				desc = "Definitions",
			},
			{
				"<leader>flt",
				"<cmd>Telescope lsp_type_definitions<cr>",
				desc = "Type Definitions",
			},
			{
				"<leader>flj",
				"<cmd>Telescope lsp_implementations<cr>",
				desc = "Implementations",
			},
			{
				"<leader>fls",
				call_telescope("lsp_document_symbols", {
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
				call_telescope("lsp_dynamic_workspace_symbols", {
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
				call_telescope("grep_string"),
				desc = "Grep string (cwd)",
				mode = {
					"v",
					"n",
				},
			},
			{
				"<leader>e",
				"<cmd>Telescope file_browser<CR>",
				desc = "Browser (root)",
			},
			{
				"<leader>E",
				"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
				desc = "Browser (cwd)",
			},
			{
				"<leader>,",
				"<cmd>Telescope buffers show_all_buffers=true<cr>",
				desc = "Switch buffers",
			},
			{
				"<leader>/",
				call_telescope("live_grep"),
				desc = "Search (root)",
			},
			{
				"<leader>?",
				call_telescope("live_grep", { cwd = false }),
				desc = "Search (cwd)",
			},
			{
				"<leader>:",
				"<cmd>Telescope command_history<cr>",
				desc = "Command History",
			},
		},
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
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
						layout_config = utils.layouts.small_cursor,
						enable_preview = true,
					},
				},
				config = function(_, opts)
					require("persisted").setup(opts)
				end,
			},
			"nvim-telescope/telescope-dap.nvim",
			"mfussenegger/nvim-dap",
			"ThePrimeagen/harpoon",
		},
		lazy = true,
		opts = {
			pickers = {
				colorscheme = {
					initial_mode = "normal",
					layout_strategy = "cursor",
					layout_config = utils.layouts.small_cursor,
					enable_preview = true,
				},
				live_grep = {},
				grep_strings = {
					initial_mode = "normal",
					layout_strategy = "horizontal",
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
					layout_config = utils.layouts.small_cursor,
				},
				lsp_references = {
					layout_config = utils.layouts.lsp,
				},
				lsp_incoming_calls = {
					layout_config = utils.layouts.lsp,
				},
				lsp_outgoing_calls = {
					layout_config = utils.layouts.lsp,
				},
				lsp_definitions = {
					layout_config = utils.layouts.lsp,
				},
				lsp_type_definitions = {
					layout_config = utils.layouts.lsp,
				},
				lsp_implementations = {
					layout_config = utils.layouts.lsp,
				},
				lsp_document_symbols = {
					layout_config = utils.layouts.lsp,
				},
				lsp_workspace_symbols = {
					layout_config = utils.layouts.lsp,
				},
				lsp_dynamic_workspace_symbols = {
					layout_config = utils.layouts.lsp,
				},
				diagnostics = {
					layout_config = utils.layouts.lsp,
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
				borderchars = utils.borderchars,
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
					center = utils.layouts.center,
					cursor = utils.layouts.cursor,
					horizontal = utils.layouts.horizontal,
					vertical = utils.layouts.vertical,
					flex = utils.layouts.flex,
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)

			require("telescope.actions")
			local trouble = require("trouble.providers.telescope")

			require("telescope").load_extension("harpoon")
			require("telescope").load_extension("aerial")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("projects")
			require("telescope").load_extension("notify")
			require("telescope").load_extension("persisted")
			require("telescope").load_extension("noice")
			require("telescope").load_extension("dap")
			require("telescope").load_extension("refactoring")

			telescope.setup({
				defaults = {
					mappings = {
						i = { ["<c-T>"] = trouble.open_with_trouble },
						n = { ["<c-T>"] = trouble.open_with_trouble },
					},
				},
			})
		end,
	},
}
