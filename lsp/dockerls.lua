local opts = {
    cmd = { "docker-langserver", "--stdio" },
    filetypes = { "dockerfile" },
    root_markers = { "Dockerfile" },
    capabilities = {},
    docs = {
        description = [[
https://github.com/rcjsuen/dockerfile-language-server-nodejs

Install:
npm install -g dockerfile-language-server-nodejs
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("capabilities").capabilities)

return opts
