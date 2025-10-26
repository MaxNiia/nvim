local opts =  {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_markers = { '.marksman.toml', '.git' },
  capabilities = {},
    docs = {
        description = [[
https://github.com/artempyanykh/marksman

Install:
sudo snap install --edge marksman # (sorry)
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("lsp").capabilities)

return opts
