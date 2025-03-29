return {
    { "rafamadriz/friendly-snippets" },
    {
        "giuxtaposition/blink-cmp-copilot",
        enabled = vim.g.enable_copilot,
    },
    {
        "saghen/blink.compat",
        enabled = vim.g.enable_copilot,
        optional = true,
        opts = {},
    },
    {
        "saghen/blink.cmp",
        build = "cargo build --release",
        lazy = false,
        opts_extend = {
            "sources.completion.enabled_providers",
            "sources.default",
        },
        opts = function()
            local opts = {
                snippets = { preset = "mini_snippets" },
                term = {
                    -- Not working on wsl
                    enabled = false,
                    keymap = {
                        preset = "inherit",
                    },
                    -- ghost_text = {
                    --     enabled = true,
                    -- },
                },
                cmdline = {
                    completion = { menu = { auto_show = true } },
                    keymap = {
                        preset = "enter",
                        ["<CR>"] = {},
                    },
                },
                keymap = {
                    preset = "enter",
                },
                appearance = {
                    use_nvim_cmp_as_default = false,
                    nerd_font_variant = "mono",
                    -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
                },
                sources = {
                    providers = {
                        cmdline = {
                            enabled = function()
                                return vim.fn.getcmdtype() ~= ":"
                                    or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
                            end,
                        },
                    },
                    default = {
                        "lsp",
                        "path",
                        "snippets",
                        "buffer",
                    },
                },
                completion = {
                    ghost_text = {
                        enabled = true,
                        show_with_selection = true,
                    },
                    list = {
                        selection = {
                            preselect = function(ctx)
                                return not require("blink.cmp").snippet_active({ direction = 1 })
                                    and ctx.mode ~= "cmdline"
                            end,
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
            }
            if vim.g.enable_copilot then
                opts = vim.tbl_deep_extend("force", opts, {
                    sources = {
                        providers = {
                            copilot = {
                                name = "copilot",
                                module = "blink-cmp-copilot",
                                score_offset = 100,
                                async = true,
                                transform_items = function(_, items)
                                    local CompletionItemKind =
                                        require("blink.cmp.types").CompletionItemKind
                                    local kind_idx = #CompletionItemKind + 1
                                    CompletionItemKind[kind_idx] = "Copilot"
                                    for _, item in ipairs(items) do
                                        item.kind = kind_idx
                                    end
                                    return items
                                end,
                            },
                            default = {
                                "lsp",
                                "path",
                                "snippets",
                                "buffer",
                                "copilot",
                            },
                        },
                    },
                })
            end
            return opts
        end,
    },
}
