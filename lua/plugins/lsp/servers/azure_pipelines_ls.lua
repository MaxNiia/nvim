return {
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                    "/azure-pipeline*.y*l",
                    "/*.azure*",
                    "Azure-Pipelines/**/*.y*l",
                    "Pipelines/*.y*l",
                },
            },
        },
    },
}
