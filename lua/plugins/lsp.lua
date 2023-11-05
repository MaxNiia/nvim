return {
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"onsails/lspkind.nvim",
			"SmiteshP/nvim-navic",
			"mfussenegger/nvim-dap",
			"hrsh7th/nvim-cmp",
			{
				"lvimuser/lsp-inlayhints.nvim",
				branch = "anticonceal";
				opts = {
				},
				config = function(_, opts)
					require("lsp-inlayhints").setup(opts)
					vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
					vim.api.nvim_create_autocmd("LspAttach", {
					  group = "LspAttach_inlayhints",
					  callback = function(args)
						if not (args.data and args.data.client_id) then
						  return
						end

						local bufnr = args.buf
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						require("lsp-inlayhints").on_attach(client, bufnr)
					  end,
					})
				end,
			}
		},
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
			-- Automatically format on save
			autoformat = true,
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			servers = {
				clangd = {
					filetypes = {
						"c",
						"cpp",
						"objc",
						"objcpp",
						"cuda",
					},
					cmd = {
						"clangd",
						"--background-index=true",
						"--clang-tidy",
						"--completion-style=detailed",
						"--all-scopes-completion=true",
						"--query-driver='/usr/bin/clang, /usr/bin/clang++'",
						"--header-insertion=iwyu",
					},
				},
				cmake = {},
				cssls = {},
				cssmodules_ls = {},
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = { "vim" },
							},
							-- Do not send telemetry data containing a randomized but unique identifier
							telemetry = {
								enable = false,
							},
						},
					},
				},
				marksman = {},
				pylsp = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							imports = {
								granularity = {
									group = "module",
								},
								prefix = "self",
							},
							cargo = {
								buildScripts = {
									enable = true,
								},
							},
							proMacro = {
								enable = true,
							},
						},
					},
				},
				tsserver = {},
				yamlls = {},
			},
			setup = {},
		},
		config = function(_, opts)
			require("neodev").setup()
			local lspconfig = require("lspconfig")
			
			-- diagnostics
			local signs = { Error = "", Warn = "", Hint = "", Info = "" }

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config(opts.diagnostics)

			-- Keybinds
			local wk = require("which-key")
			local navic = require("nvim-navic")
			local on_attach = function(client, bufnr)
				navic.attach(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Mappings
				wk.register({
					g = {
						name = "Go to",
						D = {
							vim.lsp.buf.declaration,
							"Go to declaration",
						},
						d = {
							vim.lsp.buf.definition,
							"Go to definition",
						},
						i = {
							vim.lsp.buf.implementation,
							"Go to implementation",
						},
						r = {
							require("telescope.builtin").lsp_references,
							"Go to references",
						},
					},
					K = {
						vim.lsp.buf.hover,
						"Hover",
					},
					["<C-k>"] = {
						vim.lsp.buf.signature_help,
						"Signature",
					},
					["<leader>"] = {
						W = {
							name = "Workspace",
							a = {
								vim.lsp.buf.add_workspace_folder,
								"Add workspace folder",
							},
							r = {
								vim.lsp.buf.remove_workspace_folder,
								"Remove workspace folder",
							},
							l = {
								function()
									print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
								end,
								"List workspace folder",
							},
						},
					},
				}, { buffer = bufnr })
				if client.name == "clangd" then
					wk.register({
						o = {
							"<cmd>ClangdSwitchSourceHeader<CR>",
							"Switch Header/Source",
						},
					}, {
						prefix = "<leader>",
						buffer = bufnr,
					})
				end
				-- Normal Mode
			end

			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- Specify otherwise clangd seems to use utf-8
			capabilities.offsetEncoding = { "utf-16" }

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
					on_attach = on_attach,
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				lspconfig[server].setup(server_opts)
			end

			-- temp fix for lspconfig rename
			-- https://github.com/neovim/nvim-lspconfig/pull/2439
			local mappings = require("mason-lspconfig.mappings.server")
			if not mappings.lspconfig_to_package.lua_ls then
				mappings.lspconfig_to_package.lua_ls = "lua-language-server"
				mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
			end

			local mlsp = require("mason-lspconfig")
			local available = mlsp.get_available_servers()

			local ensure_installed = {}
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(available, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			-- luasnip setup
			local luasnip = require("luasnip")

			-- Lspkind
			local lspkind = require("lspkind")

			-- nvim-cmp setup
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					docuementation = cmp.config.window.bordered(),
				},
				formatting = {
					format = function(entry, vim_item)
						if vim.tbl_contains({ "path" }, entry.source.name) then
							local icon, hl_group =
								require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
							if icon then
								vim_item.kind = icon
								vim_item.kind_hl_group = hl_group
								return vim_item
							end
						end
						return lspkind.cmp_format({ with_text = false })(entry, vim_item)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "fuzzzy_buffer" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline("/", {
				sources = cmp.config.sources({
					{
						name = "fuzzy_buffer",
					},
				}),
			})

			require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup_handlers({ setup })

			local util = require("lspconfig.util")
			lspconfig.pylsp.setup({
				root_dir = function(fname)
					local root_files = {
						"pyproject.toml",
						"setup.py",
						"setup.cfg",
						"requirements.txt",
						"Pipfile",
					}
					return util.root_pattern(unpack(root_files))(fname)
						or util.find_git_ancestor(fname)
						or vim.fn.expand("%:p:h")
				end,
			})
		end,
	},
}
