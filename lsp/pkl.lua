---@brief
---
--- https://github.com/apple/pkl-lsp

---@type vim.lsp.Config
local opts = {
    cmd = { "java", "-jar", "/usr/local/bin/pkl-lsp.jar" },
    filetypes = { "pkl" },
    root_markers = { ".editorconfig" },
    capabilities = {},
}

return opts
