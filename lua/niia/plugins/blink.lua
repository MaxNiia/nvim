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
                ["<Tab>"] = {
                    "select_next",
                    "snippet_forward",
                    "fallback",
                },
                ["<S-Tab>"] = {
                    "select_prev",
                    "snippet_backward",
                    "fallback",
                },

                cmdline = {
                    preset = "enter",
                },
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
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    },
                },
                accept = {
                    -- experimental auto-brackets support
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    draw = {
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    local kind_icon, _, _ =
                                        require("mini.icons").get("lsp", ctx.kind)
                                    return kind_icon
                                end,
                                -- Optionally, you may also use the highlights from mini.icons
                                highlight = function(ctx)
                                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                    return hl
                                end,
                            },
                        },
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
            snippets = {
                preset = "default",
            },
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
                            "documentation",
                        },
                    },
                }, opts)
            end
            require("blink.cmp").setup(opts)
        end,
    },
}
