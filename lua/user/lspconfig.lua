-- Mappings.
local opts = {
	noremap = true, 
	silent = true,
}

vim.keymap.set('n', '<Leader>f', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<C>i', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C>o', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings
	local bufopts = {
		noremap = true,
		silent = true,
		buffer = bufnr,
	}
	-- Normal Mode
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<Leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<Leader>f', function()
		vim.lsp.buf.format{
			async = true
		} 
	end, bufopts)
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
