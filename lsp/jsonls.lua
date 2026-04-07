local opts = {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
        provideFormatter = true,
    },
    capabilities = {},
    docs = {
        description = [[
https://github.com/hrsh7th/vscode-langservers-extracted

Install:
npm i -g vscode-langservers-extracted
]],
    },
}

return opts
