return {
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			"MaxNiia/nvim-navbuddy",
			"propet/colorscheme-persist.nvim",
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"onsails/lspkind.nvim",
			"SmiteshP/nvim-navic",
			"mfussenegger/nvim-dap",
			"hrsh7th/nvim-cmp",
		},
		keys = {
			{
				"<leader>k",
				vim.diagnostic.open_float,
				desc = "Open float",
			},
			{
				"<leader>j",
				vim.diagnostic.setloclist,
				desc = "Set diagnostic list",
			},
			{
				"<leader>d",
				function()
					vim.lsp.buf.format({
						async = true,
					})
				end,
				desc = "Format",
			},
			{
				"<leader>a",
				vim.lsp.buf.code_action,
				desc = "Apply fix",
			},
			{
				"<leader>rn",
				vim.lsp.buf.rename,
				desc = "Rename",
			},
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
			setup = {},
			servers = require("plugins.lsp.servers"),
		},
		config = function(_, opts)
			require("neodev").setup()
			local lspconfig = require("lspconfig")

			-- diagnostics
			local signs = { Error = "", Warn = "", Hint = "", Info = "" }

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, {
					text = icon,
					texthl = hl, --[[numhl = hl]]
				})
			end

			vim.diagnostic.config(opts.diagnostics)

			-- Keybinds
			local wk = require("which-key")
			local navic = require("nvim-navic")
			local on_attach = function(client, bufnr)
				if client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				end

				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				if client.server_capabilities.inlayHintProvider then
					wk.register({
						t = {
							function()
								vim.lsp.buf.inlay_hint(bufnr, nil)
							end,
							"Toggle inlay hints",
						},
					}, { prefix = "<leader>w", buffer = bufnr })

					vim.lsp.buf.inlay_hint(bufnr, true)
				end
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
					-- K = {
					-- 	vim.lsp.buf.hover,
					-- 	"Hover",
					-- },
					K = {
						function()
							require("pretty_hover").hover()
						end,
						"Hover",
					},
					["<c-q>"] = {
						function()
							require("pretty_hover").close()
						end,
						"Close Hover",
					},
					["<C-k>"] = {
						vim.lsp.buf.signature_help,
						"Signature",
					},
					["<leader>"] = {
						w = {
							name = "LSP",
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
			local capabilities = require("cmp_nvim_lsp").default_capabilities(
				vim.lsp.protocol.make_client_capabilities()
			)

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
							local icon, hl_group = require("nvim-web-devicons").get_icon(
								entry:get_completion_item().label
							)
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
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "fuzzzy_buffer" },
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
		end,
	},
}
