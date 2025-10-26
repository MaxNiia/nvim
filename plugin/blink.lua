require("blink.cmp").setup(
    {
        snippets = { preset = "mini_snippets" },
        term = {
            enabled = false,
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
                preset = "cmdline",
            },
        },
        keymap = {
            preset = "enter",
        },
        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
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
)
