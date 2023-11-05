-- Mappings.
local wk = require("which-key")
wk.register({
	D = {
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
			F = {
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

	if client == "clangd" then
		wk.register({
			o = {
				"<cmd>ClangdSwitchSourceHeader<CR>",
				"Switch Header/Source"
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
}

require("lspconfig")["clangd"].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	cmd = {
		"clangd",
		"--background-index=true",
		"--clang-tidy=true",
		"--completion-style=detailed",
		"--all-scopes-completion=true",
      "--query-driver='/usr/**/clang, /usr/**/clang++, /usr/**/gcc, /usr/**/g++, /home/max/workspace/dev/**/build/rcsos-3.0.0_x86_4.9.76-rt61/Debug/c_compiler_wrapper,'/home/max/workspace/dev/**/build/rcsos-3.0.0_x86_4.9.76-rt61/Debug/cxx_compiler_wrapper",
--		"--log=verbose",
	},
}

require("lspconfig")["luau_lsp"].setup{
	on_attach = on_attach,
	flags = lsp_flags,
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

