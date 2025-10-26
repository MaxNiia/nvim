local opts = {
    root_markers = { {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
    }, ".git" },
    filetypes = {
        "python",
    },
    cmd = { "basedpyright-langserver", "--stdio" },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                }
            }
        }
    },
    settings = {
        analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            typeCheckingMode = "all",
            autoImportCompletions = true,
        },
        disableOrganizeImports = false,
    },
    docs = {
        description = [[
https://github.com/DetachHead/basedpyright

Install:
pipx install basedpyright
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("lsp").capabilities)

return opts
