local opts = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    capabilities = {},
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
                ["https://json.schemastore.org/ansible-stable-2.9.json"] = "roles/tasks/*.{yml,yaml}",
                ["https://json.schemastore.org/prettierrc.json"] = ".prettierrc.{yml,yaml}",
                ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
                ["https://json.schemastore.org/chart.json"] = "Chart.{yml,yaml}",
                ["https://json.schemastore.org/circleciconfig.json"] = ".circleci/**/*.{yml,yaml}",
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                   "/azure-pipeline*.y*l",
                   "/*.azure*",
                   "Azure-Pipelines/**/*.y*l",
                   "Pipelines/*.y*l",
               },
            },
            format = {
                enable = true,
            },
            validate = true,
            hover = true,
            completion = true,
        },
    },
    docs = {
        description = [[
https://github.com/redhat-developer/yaml-language-server

Install:
npm install -g yaml-language-server
]],
    },
}

return opts
