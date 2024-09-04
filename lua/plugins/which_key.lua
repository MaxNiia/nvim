return {
    {
        "folke/which-key.nvim",
        keys = {
            { "H", "^", mode = { "n", "v", "o" }, desc = "End of line" },
            { "L", "$", mode = { "n", "v", "o" }, desc = "Start of line" },
            { "<c-d>", "<c-d>", mode = "n" },
            { "<c-u>", "<c-u>", mode = "n" },
            { "n", "nzzzv", mode = "n" },
            { "N", "Nzzzv", mode = "n" },
            { "<esc>", "<c-\\><c-n>", mode = "t" },
            { "<leader>P", '"_dp', mode = { "v", "x" }, desc = "Paste and keep" },
            {
                "<leader>y",
                '"+y',
                mode = { "n", "v", "o" },
                desc = "Yank to system",
            },
            {
                "<leader>p",
                '"+p',
                mode = { "n", "v", "o" },
                desc = "Paste from system",
            },
            {
                "<leader>H",
                "<cmd>nohl<CR>",
                mode = "n",
                desc = "Clear highlighting",
            },
            {
                "k",
                function()
                    return vim.v.count > 0 and "k" or "gk"
                end,
                mode = "n",
                expr = true,
            },
            {
                "j",
                function()
                    return vim.v.count > 0 and "j" or "gj"
                end,
                mode = "n",
                expr = true,
            },
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
        lazy = true,
        opts = {
            preset = "helix",
            plugins = {
                registers = true,
            },
            triggers = {
                { "s", mode = "nv" },
                { "<auto>", mode = "nxsotv" },
            },
            spec = {
                { "<leader><leader>", group = "Switch Window" },
                { "<leader>D", group = "Debug" },
                { "<leader>E", group = "Files" },
                { "<leader>G", group = "Git" },
                { "<leader>L", group = "LSP" },
                { "<leader>R", group = "Document" },
                { "<leader>W", group = "Sessions" },
                { "<leader>c", group = "CMake" },
                { "<leader>f", group = "Find" },
                { "<leader>g", group = "Git" },
                { "<leader>i", group = "Chat" },
                { "<leader>m", group = "Man" },
                { "<leader>r", group = "Refactor" },
                { "<leader>t", group = "Terminal" },
                { "<leader>t", group = "Test" },
                { "<leader>x", group = "Trouble" },
            },
        },
    },
}
