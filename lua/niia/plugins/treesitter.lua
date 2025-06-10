return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        cond = not vim.g.vscode,
        branch = "main",
        build = ":TSUpdate",
        cmd = { "TSLog", "TSUninstall", "TSUpdate", "TSInstall", "TSInstallFromGrammar" },
        lazy = false,
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "gdscript",
                "diff",
                "cmake",
                "rust",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "printf",
                "python",
                "query",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
        },
        config = function(_, opts)
            local already_installed = require("nvim-treesitter").get_installed()
            local parsers_to_install = vim.iter(opts.ensure_installed)
                :filter(function(parser)
                    return not vim.tbl_contains(already_installed, parser)
                end)
                :totable()
            require("nvim-treesitter").install(parsers_to_install)
        end,
    },
}
