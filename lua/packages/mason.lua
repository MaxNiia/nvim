require("mason").setup()
require("mason-lspconfig").setup({
   ensure_installed = {
      "clangd",
      "cmake",
      "sumneko_lua",
      "pyright",
      "rust_analyzer",
   },
})
