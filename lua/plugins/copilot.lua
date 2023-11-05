return {
    -- {
    --     "github/copilot.vim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-lua/popup.nvim",
    --         "nvim-telescope/telescope.nvim",
    --     },
    --     init = function()
    --         vim.g.copilot_keymap = true
    --         vim.g.copilot_auto_start = true
    --         vim.g.copilot_no_tab_map = true

    --         local wk = require("which-key")
    --         wk.register({
    --             ["<C-j>"] = {
    --                 "<Plug>(copilot-Accept)",
    --                 "Copilot accept",
    --             },
    --             ["<C-k>"] = {
    --                 "<Plug>(copilot-dismiss)",
    --                 "Copilot dismiss",
    --             },
    --             ["<C-h>"] = {
    --                 "<Plug>(copilot-previous)",
    --                 "Copilot previous",
    --             },
    --             ["<C-l>"] = {
    --                 "<Plug>(copilot-next)",
    --                 "Copilot next",
    --             },
    --         }, { mode = "i" })

    --         -- imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
    --     end,
    -- },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                    auto_refresh = false,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>",
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.4,
                    },
                },
                suggestion = {
                    enabled = false,
                    auto_trigger = false,
                    debounce = 75,
                    keymap = {
                        accept = "<M-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
            })
        end,
    },
}
