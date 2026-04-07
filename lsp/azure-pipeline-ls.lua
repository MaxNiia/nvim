local opts = {
    cmd = { "azure-pipelines-language-server", "--stdio" },
    filetypes = { "yaml" },
    root_markers = {{ "azure-pipelines.yml" }},
    settings = {},
    capabilities = {},
    docs = {
        description = [[
https://github.com/microsoft/azure-pipelines-language-server

Install:
npm i -g azure-pipelines-language-server
]],
    },
}

return opts
