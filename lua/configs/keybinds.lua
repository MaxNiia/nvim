local wk = require("which-key")

-- Global non buffer specific keybinds.

local function createAICommand(method)
	return string.format("<Cmd>lua require('nvim-magic.flows').%s(require('nvim-magic').backends.default)<CR>", method)
end

local function getCount()
	return vim.v.count
end

local dap = require("dap")
local breakpoint = require("goto-breakpoints")

wk.register({
	{
		-- normal, visual, select, operator
		mode = { "n", "v", "o" },
		H = {
			"^",
			"End of line",
		},
		L = {
			"$",
			"Start of line",
		},
	}, -- normal, visual, select, operator
	{
		-- command
		mode = "c",
	}, -- command
	{
		-- insert
		mode = "i",
	}, -- insert
	{
		-- insert, command, lang
		mode = "l",
	}, -- insert, command, lang
	{
		--normal
		mode = "n",

		["<leader>"] = {
			-- ai
			c = {
				name = "+ChatGPT",
				c = {
					createAICommand("suggest_chat"),
					"Chat",
				},
				r = {
					createAICommand("suggest_chat_reset"),
					"Reset",
				},
			},
			-- close_buffers
			q = {
				function()
					require("close_buffers").delete({ type = "this" })
				end,
				"Delete current buffer",
			},
			Q = {
				function()
					require("close_buffers").delete({ type = "other" })
				end,
				"Delete other buffers",
			},
			-- dap
			b = {
				name = "+Debug",
				B = {
					function()
						vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
							dap.set_breakpoint(condition)
						end)
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
			-- lsp
			k = {
				vim.diagnostic.open_float,
				"Open float",
			},
			j = {
				vim.diagnostic.setloclist,
				"Set loc list",
			},
			d = {
				function()
					vim.lsp.buf.format({
						async = true,
					})
				end,
				"Format",
			},
			a = {
				vim.lsp.buf.code_action,
				"Apply fix",
			},
			rn = {
				vim.lsp.buf.rename,
				"Rename",
			},
			-- swenv
			v = {
				function()
					require("swenv.api").pick_venv()
				end,
				"Pick venv",
			},
			-- telescope
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
			-- toggleterm
			t = {
				name = "+Terminal",
				l = {
					"<cmd>ToggleTermSendCurrentLine<CR>",
					"Send line",
				},
				a = {
					"<cmd>ToggleTermToggleAll<CR>",
					"Toggle all terminals",
				},
			},
			-- trouble
			x = {
				name = "Trouble",
				x = {
					"<cmd>TroubleToggle<cr>",
					"Trouble",
				},
				w = {
					"<cmd>TroubleToggle workspace_diagnostics<cr>",
					"Workspace",
				},
				d = {
					"<cmd>TroubleToggle document_diagnostics<cr>",
					"Document",
				},
				q = {
					"<cmd>TroubleToggle quickfix<cr>",
					"Quickfix",
				},
				l = {
					"<cmd>TroubleToggle loclist<cr>",
					"Loc list",
				},
				r = {
					"<cmd>TroubleToggle lsp_references<cr>",
					"References",
				},
			},
			-- Misc
			C = {
				"<cmd>nohl<CR>",
				"Clear highlighting",
			},
			z = {
				function()
					if vim.o.relativenumber  then
						vim.o.relativenumber = 0
					else
						vim.o.relativenumber = 1
					end
				end,
				"Toggle relative line numbers",
			},
			y = {
				"\"+y",
				"Yank to system clipboard",
			},
			p = {
				"\"+p",
				"Paste from system clipboard",
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
	{
		-- operator
		mode = "o",
	}, -- operator
	{
		-- select
		mode = "s",
	}, -- select
	{
		-- terminal
		mode = "t",
	}, -- terminal
	{
		-- visual, select
		mode = "v",
		["<leader>"] = {
			-- ai
			c = {
				name = "+ChatGPT",
				s = {
					createAICommand("append_completion"),
					"Completion",
				},
				a = {
					createAICommand("suggest_alteration"),
					"Alteration",
				},
				d = {
					createAICommand("suggest_docstring"),
					"Docstring",
				},
				c = {
					createAICommand("suggest_chat"),
					"Chat",
				},
				r = {
					createAICommand("suggest_chat_reset"),
					"Reset",
				},
			},
			-- telescope
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
			-- Misc
			y = {
				"\"+y",
				"Yank to system clipboard",
			},
			p = {
				"\"+p",
				"Paste from system clipboard",
			},
		}, -- leader
	}, -- visual, select
	{
		-- visual
		mode = "x",
	}, -- visual
}, {})
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("t", "<esc>", "<c-\\><c-n>")
vim.keymap.set("x", "<leader>p", '"_dP')
