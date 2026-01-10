local opts = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
    root_markers = { ".git" },
    capabilities = {},
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
        },
    },
    docs = {
        description = [[
https://github.com/bash-lsp/bash-language-server

Install:
npm install -g bash-language-server
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("lsp").capabilities)

return opts
