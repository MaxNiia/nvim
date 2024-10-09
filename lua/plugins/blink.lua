return {
    {
        "saghen/blink.cmp",
        lazy = false,
        build = "cargo build --release",
        dependencies = {
            "rafamadriz/friendly-snippets",
            {
                "chrisgrieser/nvim-scissors",
                dependencies = { "nvim-telescope/telescope.nvim", "garymjr/nvim-snippets" },
                opts = {
                    snippetDir = vim.fn.stdpath("config") .. "/snippets",
                },
            },
        },
        opts = {
            highlight = {
                -- sets the fallback highlight groups to nvim-cmp's highlight groups
                -- useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release, assuming themes add support
                use_nvim_cmp_as_default = true,
            },

            -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",

            -- experimental auto-brackets support
            accept = { auto_brackets = { enabled = true } },

            -- experimental signature help support
            trigger = { signature_help = { enabled = true } },

            keymap = {
                show = "<C-space>",
                hide = "<C-e>",
                accept = "<CR>",
                select_prev = { "<Up>", "<C-k>", "<S-Tab>" },
                select_next = { "<Down>", "<C-j>", "<Tab>" },

                show_documentation = {},
                hide_documentation = {},
                scroll_documentation_up = "<C-b>",
                scroll_documentation_down = "<C-f>",

                snippet_forward = "<Tab>",
                snippet_backward = "<S-Tab>",
            },
        },
    },
}
