local opts = {
    cmd = { "taplo", "lsp", "stdio" },
    filetypes = { "toml" },
    root_markers = { "*.toml" },
    capabilities = {},
    settings = {
        taplo = {
            formatter = {
                alignEntries = false,
                arrayTrailingComma = true,
                arrayAutoExpand = true,
                compactArrays = true,
                compactInlineTables = false,
                indentTables = false,
            },
        },
    },
    docs = {
        description = [[
https://github.com/tamasfe/taplo

Install:
cargo install --locked taplo-cli
]],
    },
}

return opts
