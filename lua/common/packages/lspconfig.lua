-- Mappings.
local wk = require("which-key")
wk.register({
	j = {
		vim.diagnostic.open_float,
		"Open float",
	},
	q = {
		vim.diagnostic.setloclist,
		"Set loc list"
	},
}, {
	prefix = "<leader>",
})

wk.register({
	k = {
		vim.diagnostic.goto_prev,
		"Previous diagnostic",
	},
	j = {
		vim.diagnostic.goto_next,
		"Next diagnostic",
	}
}, {
	prefix = "<C>",
})

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings
	local wk = require("which-key")
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
				vim.lsp.buf.references,
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
			w = {
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
			rn = {
				vim.lsp.buf.rename,
				"Rename",
			},
			d = {
				function()
					vim.lsp.buf.format{
						async = true
					} 
				end,
				"Format",
			},
		},
	},{ buffer = bufnr,
	})
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

local lsp_flags = {
	debounce_text_change = 150
}

require("lspconfig")["pyright"].setup{
	on_attach = on_attach,
	flags = lsp_flags,
   settings = {
      python = {
         analysis = {
            autoImportCompletions = true,
            ausoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
         },
      },
   },
}

require("lspconfig")["clangd"].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	cmd = {
		"/home/max/clangd_15.0.3/bin/clangd",
		"--background-index=true",
		"--clang-tidy=true",
		"--completion-style=detailed",
		"--all-scopes-completion=true",
      "--query-driver='/usr/bin/gcc, /usr/bin/g++'", -- gcc
	},
}

require("lspconfig")["cmake"].setup{
   buildDirectory = "build/rcsos-2.4.0_x86_4.4.50_rt63/Debug" 
}

require("lspconfig")["sumneko_lua"].setup{
	on_attach = on_attach,
	flags = lsp_flags,
   settings = {
      Lua = {
         runtime = {
            version = 'LuaJIT',
         },
         diagnostics = {'vim'},
         workspace = {
            libray = vim.api.nvim_get_runtime_file("", true),
         },
         telemetry = {
            enable = false,
         },
      },
   },
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

