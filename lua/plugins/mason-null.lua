return {
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"beutysh",
				"buf",
				"cmake_lint",
				"cmake_format",
				"commitlint",
				"cpell",
				"eslint_d",
				"flake8",
				"gitlint",
				"gitrebase",
				"gitsigns",
				"hadolint",
				"jsonlint",
				"luasnip",
				"markdownlint",
				"mypy",
				"stylua",
				"zsh",
			},
			automatic_setup = true,
		},
		config = function(_, opts)
			local null_ls = require("null-ls")

			opts.handlers = {
				function(source_name, methods)
					require("mason-null-ls.automatic_setup")(source_name, methods)
				end,
				cmake_format = function(_, _)
					null_ls.register(null_ls.builtins.formatting.cmake_format)
				end,
				stylua = function(_, _)
					null_ls.register(null_ls.builtins.formatting.stylua)
				end,
				flake8 = function(_, _)
					null_ls.register(null_ls.builtins.diagnostics.flake8)
				end,
				eslint_d = function(_, _)
					null_ls.register(null_ls.builtins.code_actions.eslint_d)
					null_ls.register(null_ls.builtins.diagnostics.eslint_d)
					null_ls.register(null_ls.builtins.formatting.eslint_d)
				end,
				gitrebase = function(_, _)
					null_ls.register(null_ls.builtins.code_actions.gitrebase)
				end,
				gitsigns = function(_, _)
					null_ls.register(null_ls.builtins.code_actions.gitsigns.with({
						-- filter out blame actions
						config = {
							filter_actions = function(title)
								return title:lower():match("blame") == nil
							end,
						},
					}))
				end,
				gitlint = function(_, _)
					null_ls.register(null_ls.builtins.diagnostics.gitlint)
				end,
				luasnip = function(_, _)
					null_ls.register(null_ls.builtins.completion.luasnip)
				end,
				buf = function(_, _)
					null_ls.register(null_ls.builtins.diagnostics.buf)
					null_ls.register(null_ls.builtins.formatting.buf)
				end,
				cmake_lint = function(_, _)
					null_ls.register(null_ls.builtins.diagnostics.cmake_lint)
				end,
				commitlint = function(_, _)
					null_ls.register(null_ls.builtins.diagnostics.commitlint)
				end,
				cspell = function(_, _)
					null_ls.register(null_ls.builtins.diagnostics.cspell)
					null_ls.register(null_ls.builtins.code_actions.cspel)
				end,
				hadolint = function(_, _)
					null_ls.register(null_ls.builtins.diagnostics.hadolint)
				end,
				jsonlint = function(_, _)
					null_ls.register(null_ls.builtins.diagnostics.jsonlint)
				end,
				markdownlint = function(_, _)
					null_ls.register(null_ls.builtins.diagnostics.markdownlint)
					null_ls.register(null_ls.builtins.formatting.markdownlint)
				end,
				mypy = function(_, _)
					null_ls.register(null_ls.builtins.diagnostics.mypy)
				end,
				zsh = function(_, _)
					null_ls.register(null_ls.builtins.diagnostics.zsh)
				end,
				beutysh = function(_, _)
					null_ls.register(null_ls.builtins.formatting.beautysh)
				end,
			}

			require("mason-null-ls").setup(opts)

			null_ls.setup()
		end,
	},
}
