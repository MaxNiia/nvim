return {
    settings = {
        pylsp = {
            configurationSources = {
                "pycodestyle",
                "flake8",
            },
            plugins = {
                pylsp_mypy = { enabled = true, live_mode = true },
                black = {
                    enabled = true,
                    line_length = 120,
                },
                autopep8 = {
                    enabled = true,
                },
                flake8 = {
                    enabled = true,
                    maxLineLength = 120,
                },
                pycodestyle = {
                    enabled = true,
                    maxLineLength = 120,
                },
                pydocstyle = {
                    enabled = true,
                },
                pylint = {
                    enabled = true,
                },
                rope_autoimport = {
                    enabled = true,
                    memory = true,
                },
                rope_completion = {
                    enabled = true,
                    eager = true,
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
