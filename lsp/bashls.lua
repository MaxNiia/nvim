local opts = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
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

return opts
