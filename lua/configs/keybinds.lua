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
local function telescope(builtin, opts)
	local params = { builtin = builtin, opts = opts }
	return function()
		builtin = params.builtin
		opts = params.opts
		opts = vim.tbl_deep_extend("force", { cwd = get_root() }, opts or {})
		if builtin == "files" then
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
					telescope(
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
			f = {
				name = "+Find",
				-- c = {
				-- 	telescope("colorscheme", { enable_preview = true }),
				-- 	"Colorscheme",
				-- },
				c = {
					function ()
						require("colorscheme-persist").picker()
					end,
					"Colorscheme"
				},
				r = {
					"<cmd>Telescope resume<CR>",
					"Resume",
				},
				t = {
					"<cmd>Telescope<CR>",
					"Telescope",
				},
				j = {
					telescope("grep_string"),
					"Grep string (root)",
				},
				J = {
					telescope("grep_string", { cwd = false }),
					"Grep string (cwd)",
				},
				f = {
					telescope("files"),
					"Files (root dir)",
				},
				F = {
					telescope("files", { cwd = false }),
					"Files (cwd)",
				},
				b = {
					"<cmd>Telescope buffers<CR>",
					"Buffers",
				},
				d = {
					name = "+Debug",
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
				O = {
					telescope("oldfiles", { cwd = vim.loop.cwd() }),
					"Old files (cwd)",
				},
				s = {
					telescope("live_grep"),
					"Search (root dir)",
				},
				S = {
					telescope("live_grep", { cwd = false }),
					"Search (cwd)",
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
				k = {
					"<cmd>Telescope keymaps<cr>",
					"Key Maps",
				},
				l = {
					name = "+LSP",
					r = {
						"<cmd>Telescope lsp_references<cr>",
						"References",
					},
					i = {
						"<cmd>Telescope lsp_incoming_calls<cr>",
						"Incoming",
					},
					o = {
						"<cmd>Telescope lsp_outgoing_calls<cr>",
						"Incoming",
					},
					d = {
						"<cmd>Telescope lsp_definitions<cr>",
						"Definitions",
					},
					t = {
						"<cmd>Telescope lsp_type_definitions<cr>",
						"Type Definitions",
					},
					j = {
						"<cmd>Telescope lsp_implementations<cr>",
						"Implementations",
					},
					s = {
						telescope("lsp_document_symbols", {
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
						"Goto Symbol",
					},
					S = {
						telescope("lsp_dynamic_workspace_symbols", {
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
						"Goto Symbol (Workspace)",
					},
				},
			},
			e = {
				"<cmd>Telescope file_browser<cr>",
				"Browser",
			},
			s = {
				telescope("grep_string"),
				"Grep string (root)",
			},
			S = {
				telescope("grep_string", { cwd = false }),
				"Grep string (cwd)",
			},
			[","] = {
				"<cmd>Telescope buffers show_all_buffers=true<cr>",
				"Switch buffers",
			},
			["/"] = {
				telescope("live_grep"),
				"Search (root)",
			},
			["?"] = {
				telescope("live_grep", { cwd = false }),
				"Search (cwd)",
			},
			[":"] = {
				"<cmd>Telescope command_history<cr>",
				"Command History",
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
					if vim.o.relativenumber then
						vim.o.relativenumber = 0
					else
						vim.o.relativenumber = 1
					end
				end,
				"Toggle relative line numbers",
			},
			y = {
				'"+y',
				"Yank to system clipboard",
			},
			p = {
				'"+p',
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
					"Grep string (root)",
				},
				J = {

					telescope("grep_string"),
					"Grep string (cwd)",
				},
			},
			s = {
				telescope("grep_string"),
				"Grep string (root)",
			},
			S = {
				telescope("grep_string", { cwd = false }),
				"Grep string (cwd)",
			},
			-- Misc
			y = {
				'"+y',
				"Yank to system clipboard",
			},
			p = {
				'"+p',
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
