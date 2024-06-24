return {
    {
        "nvim-treesitter/nvim-treesitter",
        cond = not vim.g.vscode,
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-context",
            },
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function()
                    -- PERF: no need to load the plugin, if we only need its queries for mini.ai
                    local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
                    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
                    local enabled = false
                    if opts.textobjects then
                        for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
                            if opts.textobjects[mod] and opts.textobjects[mod].enable then
                                enabled = true
                                break
                            end
                        end
                    end
                    if not enabled then
                        require("lazy.core.loader").disable_rtp_plugin(
                            "nvim-treesitter-textobjects"
                        )
                    end
                end,
            },
        },
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            highlight = {
                enable = true,
                use_languagetree = true,
                -- Uses vim regex highlighting
                additional_vim_regex_highlighting = false,
            },
            rainbow = {
                enable = true,
                -- disable = { list of languages },
                extended_mode = true,
                max_file_lines = 10000,
            },
            indent = {
                enable = true,
            },
            ensured_install = {
                "bash",
                "c",
                "cpp",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "rust",
                "vim",
                "vimdoc",
                "json",
                "yaml",
            },
            auto_install = true,
        },
        config = function(_, opts)
            require("nvim-treesitter").setup()

            require("nvim-treesitter.configs").setup(opts)

            require("treesitter-context").setup({
                enable = true,
                max_lines = 30,
                trim_scope = "outer",
                separator = "_",
            })
        end,
    },
}
