return {
    {
        "saghen/blink.cmp",
        dependencies = {
            {
                "giuxtaposition/blink-cmp-copilot",
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
            cmdline = {
                keymap = {
                    preset = "enter",
                    ["<CR>"] = {},
                    ["<Down>"] = {
                        "select_next",
                        "fallback",
                    },
                    ["<Up>"] = {
                        "select_prev",
                        "fallback",
                    },
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
                },
            },
            keymap = {
                preset = "enter",
                ["<Down>"] = {
                    "select_next",
                    "fallback",
                },
                ["<Up>"] = {
                    "select_prev",
                    "fallback",
                },
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
            },

            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
                -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
            },
            sources = {
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                        transform_items = function(_, items)
                            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                            local kind_idx = #CompletionItemKind + 1
                            CompletionItemKind[kind_idx] = "Copilot"
                            for _, item in ipairs(items) do
                                item.kind = kind_idx
                            end
                            return items
                        end,
                    },
                    cmdline = {
                        enabled = function()
                            return vim.fn.getcmdline():sub(1, 1) ~= "!"
                        end,
                    },
                },
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                    vim.g.enable_copilot and "copilot" or nil,
                },
            },

            completion = {
                ghost_text = {
                    enabled = true,
                    show_with_selection = true,
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = function(ctx)
                            return ctx.mode == "cmdline"
                        end,
                    },
                },
                accept = {
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
                                    if ctx.kind == "Copilot" then
                                        return require("niia.utils.icons").kinds.Copilot
                                    end
                                    local kind_icon, _, _ =
                                        require("mini.icons").get("lsp", ctx.kind)
                                    return kind_icon
                                end,
                                -- Optionally, you may also use the highlights from mini.icons
                                highlight = function(ctx)
                                    if ctx.kind == "Copilot" then
                                        return "CmpItemKindCopilot"
                                    end
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
            },

            signature = { enabled = true },
            snippets = {
                preset = "default",
            },
        },
    },
}
