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

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
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
				prompt_prefix = "  ",
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
				layout_strategy = "flex",
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
						results_width = 0.8,
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
