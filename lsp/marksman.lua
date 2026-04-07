local opts = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown" },
    root_markers = { ".marksman.toml" },
    capabilities = {},
    docs = {
        description = [[
https://github.com/artempyanykh/marksman

Install:
sudo snap install --edge marksman # (sorry)
]],
    },
}

return opts
