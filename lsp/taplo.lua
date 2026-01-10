local opts = {
    cmd = { "taplo", "lsp", "stdio" },
    filetypes = { "toml" },
    root_markers = { "*.toml", ".git" },
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

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("lsp").capabilities)

return opts
