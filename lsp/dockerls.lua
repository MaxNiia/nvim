local opts = {
  cmd = { 'docker-langserver', '--stdio' },
  filetypes = { 'dockerfile' },
  root_markers = { 'Dockerfile' },
  capabilities = {},
    docs = {
        description = [[
https://github.com/salesforce-misc/bazelrc-lsp

Install:
Manually build and alias.
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("lsp").capabilities)

return opts
