return {
    { "rafamadriz/friendly-snippets" },
    {
        "giuxtaposition/blink-cmp-copilot",
        enabled = vim.g.enable_copilot_cmp,
        cond = not vim.g.vscode,
    },
    {
        "saghen/blink.compat",
        enabled = vim.g.enable_copilot_cmp,
        optional = true,
        cond = not vim.g.vscode,
        opts = {},
    },
    {
        cond = not vim.g.vscode,
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
                    -- ghost_text = {
                    --     enabled = true,
                    -- },
                },
                cmdline = {
                    completion = {
                        list = {
                            selection = {
                                preselect = false,
                                auto_insert = true,
                            },
                        },
                        menu = {
                            -- auto_show = true
                            auto_show = function(
                                _ --[[ctx]]
                            )
                                return vim.fn.getcmdtype() == ":"
                                -- enable for inputs as well, with:
                                -- or vim.fn.getcmdtype() == '@'
                            end,
                        },
                    },
                    keymap = {
                        ["<Tab>"] = {
                            "show",
                            "accept",
                        },
                        ["<CR>"] = {
                            "accept_and_enter",
                            "fallback",
                        },
                        preset = "cmdline",
                    },
                },
                keymap = {
                    ["<Tab>"] = {
                        "snippet_forward",
                        function() -- sidekick next edit suggestion
                            return require("sidekick").nes_jump_or_apply()
                        end,
                        function() -- if you are using Neovim's native inline completions
                            return vim.lsp.inline_completion.get()
                        end,
                        "fallback",
                    },
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
                            min_keyword_length = function(ctx)
                                -- when typing a command, only show when the keyword is 3 characters or longer
                                if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                                    return 3
                                end
                                return 0
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
                            preselect = true,
                            auto_insert = true,
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
            if vim.g.enable_copilot_cmp then
                opts = vim.tbl_deep_extend("force", opts, {
                    sources = {
                        default = {
                            "lsp",
                            "path",
                            "snippets",
                            "buffer",
                            "copilot",
                        },
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
                        },
                    },
                })
            end
            return opts
        end,
    },
}
