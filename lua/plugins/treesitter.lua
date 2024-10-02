return {
    {
        "nvim-treesitter/nvim-treesitter",
        cond = not vim.g.vscode,
        dependencies = {
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
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ia"] = "@parameter.inner",
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ["ic"] = {
                            query = "@class.inner",
                            desc = "Select inner part of a class region",
                        },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V", -- linewise
                        ["@class.outer"] = "<c-v>", -- blockwise
                    },
                    include_surrounding_whitespace = true,
                },
            },
            highlight = {
                enable = true,
                use_languagetree = true,
                -- Uses vim regex highlighting
                additional_vim_regex_highlighting = true,
            },
            rainbow = {
                enable = true,
                -- disable = { list of languages },
                extended_mode = true,
                max_file_lines = 10000,
            },
            indent = {
                enable = true,
                disable = { "yaml" },
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
        end,
    },
}
