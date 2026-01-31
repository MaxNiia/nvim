local opts = {
    root_markers = { "_typos.toml", "typos.toml", ".typos.toml", ".git" },
    init_options = { -- Sent to the LSP on init
        diagnosticSeverity = "Hint",
    },
    cmd = {
        "typos-lsp",
    },
    capabilities = {},
    docs = {
        description = [[
https://github.com/tekumara/typos-lsp

Install:
cargo install --git https//github.com/tekumara/typos-lsp typos-lsp
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", require("capabilities").capabilities, opts.capabilities)

return opts
