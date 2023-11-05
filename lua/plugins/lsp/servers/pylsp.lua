return {
    plugins = {
        autopep8 = {
            enabled = true,
        },
        flake8 = {
            enabled = true,
        },
        pycodestyle = {
            enabled = true,
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
