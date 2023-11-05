return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"ofirgall/goto-breakpoints.nvim",
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/cmp-dap",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
			},
			opts = {
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = true,
				all_references = false,
				show_stop_reason = true,
				commented = false,
				virt_text_pos = "inline",
				only_first_definition = true,
			},
			setup = true,
		},
		config = function(_, opts)
			require("nvim-dap-virtual-text").setup(opts)

			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "לּ", texthl = "Error" })
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "Directory" })
			vim.fn.sign_define("DapStopped", { text = "ﰲ", texthl = "TSConstant" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "Error" })

			require("cmp").setup({
				enabled = function()
					return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
						or require("cmp_dap").is_dap_buffer()
				end,
			})

			require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
				sources = {
					{ name = "dap" },
				},
			})

			local wk = require("which-key")
			local dap = require("dap")
			local breakpoint = require("goto-breakpoints")
			wk.register({
				{
					["<leader>"] = {
						b = {
							name = "Debug",
							B = {
								function()
									vim.ui.input(
										{ prompt = "Breakpoint condition: " },
										function(condition)
											dap.set_breakpoint(condition)
										end
									)
								end,
								"DAP set conditional breakpoint",
							},
							c = {
								dap.continue,
								"Continue",
							},
							s = {
								dap.step_over,
								"Step Over",
							},
							i = {
								dap.step_into,
								"Step Into",
							},
							o = {
								dap.step_out,
								"Step Out",
							},
							b = {
								dap.toggle_breakpoint,
								"Breakpoint",
							},
							R = {
								dap.repl.open,
								"Open repl",
							},
							l = {
								dap.run_last,
								"Run last session",
							},
							r = {
								dap.restart,
								"Restart session",
							},
							q = {
								dap.terminate,
								"Terminate session",
							},
						},
					}, -- leader
					-- dap
					["]b"] = {
						breakpoint.next,
						"Go to next breakpoint",
					},
					["[b"] = {
						breakpoint.prev,
						"Go to prev breakpoint",
					},
				}, -- normal
			}, {
				mode = "n",
			})
		end,
	},
}
