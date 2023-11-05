return {
    settings = {
        pylsp = {
            configurationSources = {
                "flake8",
            },
            plugins = {
                isort = {
                    enabled = true,
                },
                pylsp_mypy = {
                    enabled = true,
                    live_mode = true,
                    line_length = 120,
                },
                mccabe = {
                    enabled = false,
                },
                black = {
                    enabled = true,
                    line_length = 120,
                },
                autopep8 = {
                    enabled = true,
                    line_length = 120,
                },
                pyflakes = {
                    enabled = false,
                },
                flake8 = {
                    enabled = true,
                    maxLineLength = 120,
                    -- indentSize = 4,
                },
                jedi_completion = {
                    enabled = true,
                    fuzzy = true,
                },
                jedi_definition = {
                    enabled = true,
                    follow_imports = true,
                    follow_builtin_imports = true,
                    follow_builtin_definitions = true,
                },
                jedi_hover = {
                    enabled = true,
                },
                jedi_references = {
                    enabled = true,
                },
                jedi_signature_help = {
                    enabled = true,
                },
                jedi_symbols = {
                    enabled = true,
                    all_scopes = true,
                    include_import_symbols = true,
                },
                pycodestyle = {
                    enabled = false,
                    maxLineLength = 120,
                    indentsize = 4,
                },
                pydocstyle = {
                    enabled = true,
                },
                pylint = {
                    enabled = false,
                    line_length = 120,
                },
                rope_autoimport = {
                    enabled = true,
                    memory = true,
                    line_length = 120,
                },
                rope_completion = {
                    enabled = true,
                    eager = true,
                    line_length = 120,
                },
            },
        },
    },
    single_file_support = true,
    root_dir = function(fname)
        local root_files = {
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
        }
        local util = require("lspconfig.util")
        return util.root_pattern(unpack(root_files))(fname)
            or util.find_git_ancestor(fname)
            or vim.fn.expand("%:p:h")
    end,
}
