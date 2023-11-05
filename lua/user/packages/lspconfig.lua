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
	i = {
		vim.diagnostic.goto_prev,
		"Previous diagnostic",
	},
	o = {
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
	cmde = {
		"clangd",
		"--background-index",
		"--suggest-missing-includes",
	},
}

require("lspconfig")["luau_lsp"].setup{
	on_attach = on_attach,
	flags = lsp_flags,
}
