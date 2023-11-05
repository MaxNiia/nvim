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
			extensions = {
				file_browser = {
					hijack_netrw = true,
					display_stat = false,
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
				prompt_prefix = "   ",
				border = {},
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				color_devicons = true,
				borderchars = {
					{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					prompt = { "─", "│", " ", "│", "┌", "┬", "│", "│" },
					results = { "─", "│", "─", "│", "├", "┤", "┴", "└" },
					preview = { "─", "│", "─", " ", "─", "┐", "┘", "─" },
				},
				winblend = 0,
				wrap_results = false,
				path_display = { truncate = 20 },
				selection_caret = "  ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				prompt_title = "",
				results_title = "",
				preview_title = "",
				layout_stratergy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						height = 0.8,
						width = 0.7,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)

			require("telescope.actions")
			require("trouble.providers.telescope")

			require("telescope").load_extension("aerial")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("projects")
			require("telescope").load_extension("notify")
			require("telescope").load_extension("persisted")
			require("telescope").load_extension("noice")
			require("telescope").load_extension("dap")

			local wk = require("which-key")
			wk.register({
				e = {
					"<cmd>Telescope file_browser<CR>",
					"Browser",
				},
				s = {
					"<cmd>Telescope grep_string<CR>",
					"Grep string",
				},
				f = {
					name = "+Find",
					t = {
						"<cmd>Telescope<CR>",
						"Telescope",
					},
					j = {
						"<cmd>Telescope grep_string<CR>",
						"Grep string",
					},
					f = {
						"<cmd>Telescope find_files<CR>",
						"Files",
					},
					b = {
						"<cmd>Telescope buffers<CR>",
						"Buffers",
					},
					d = {
						"+Debug",
						c = {
							"<cmd>Telescope dap commands<CR>",
							"Commands",
						},
						b = {
							"<cmd>Telescope dap list_breakpoints<CR>",
							"Breakpoints",
						},
						v = {
							"<cmd>Telescope dap variables<CR>",
							"Variables",
						},
						f = {
							"<cmd>Telescope dap frames<CR>",
							"Frames",
						},
						x = {
							"<cmd>Telescope dap configurations<CR>",
							"Configurations",
						},
					},
					o = {
						"<cmd>Telescope oldfiles<CR>",
						"Old files",
					},
					s = {
						"<cmd>Telescope live_grep<CR>",
						"Search",
					},
					q = {
						"<cmd>Telescope spell_suggest<CR>",
						"Dictionary",
					},
					p = {
						"<cmd>Telescope projects<CR>",
						"Project",
					},
					n = {
						"<cmd>Telescope noice<CR>",
						"Noice",
					},
					M = {
						"<cmd>Telescope notify<CR>",
						"Notify",
					},
					m = {

						"<cmd>Telescope manpages<CR>",
						"Manpages",
					},
					g = {
						name = "Git",
						s = {
							"<cmd>Telescope git_status<CR>",
							"Git status",
						},
						b = {
							"<cmd>Telescope git_branches<CR>",
							"Git branches",
						},
						c = {
							"<cmd>Telescope git_commits<CR>",
							"Git commits",
						},
					},
					a = {
						"<cmd>Telescope aerial<CR>",
						"Aerial",
					},
					w = {
						name = "Sessions",
						s = {
							"<cmd>SessionLoad<cr>",
							"Restore directory session",
						},
						l = {
							"<cmd>SessionLoadLast<cr>",
							"Restore last session",
						},
						d = {
							"<cmd>SessionStop<cr>",
							"Don't save",
						},
					},
				},
			}, {
				prefix = "<leader>",
			})

			wk.register({
				f = {
					name = "+Find",
					j = {

						"<cmd>Telescope grep_string<CR>",
						"Grep string",
					},
				},
				s = {
					"<cmd>Telescope grep_string<CR>",
					"Grep string",
				},
			}, { prefix = "<leader>", mode = "v" })
		end,
	},
}
