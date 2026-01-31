local opts = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
        provideFormatter = true,
    },
    root_markers = { ".git" },
    capabilities = {},
    docs = {
        description = [[
https://github.com/hrsh7th/vscode-langservers-extracted

Install:
npm i -g vscode-langservers-extracted
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", require("capabilities").capabilities, opts.capabilities)

return opts
