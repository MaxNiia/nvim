require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "cmake",
        "sumneko_lua",
        "rust_analyzer",
        "pyright",
    },
})

local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
	automatic_setup = true,
})

null_ls.setup()

mason_null_ls.setup_handlers()
