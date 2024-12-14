return {
    {
        "saghen/blink.cmp",
        dependencies = {
            {
                "giuxtaposition/blink-cmp-copilot",
                cond = vim.g.enable_copilot,
            },
            {
                "saghen/blink.compat",
                optional = true,
                opts = {},
            },
        },
        build = "cargo build --release",
        lazy = false,
        opts_extend = {
            "sources.completion.enabled_providers",
            "sources.default",
        },
        opts = {
            keymap = {
                preset = "enter",
                ["<C-y>"] = { "select_and_accept" },
            },

            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
                cmdline = {},
            },

            completion = {
                list = {
                    selection = "manual",
                },
                accept = {
                    -- experimental auto-brackets support
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                ghost_text = {
                    enabled = true,
                },
            },

            signature = { enabled = true },
        },
        config = function(_, opts)
            if vim.g.enable_copilot then
                opts = vim.tbl_deep_extend("force", {
                    sources = {
                        providers = {
                            copilot = {
                                name = "copilot",
                                module = "blink-cmp-copilot",
                            },
                        },
                        default = {
                            "lsp",
                            "path",
                            "snippets",
                            "buffer",
                            "copilot",
                        },
                    },
                }, opts)
            end
            require("blink.cmp").setup(opts)
        end,
    },
}
