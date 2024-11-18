return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
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
                "Q",
                "<cmd>wq<cr>",
                mode = { "n", "v", "o" },
                desc = "Save and quit buffer",
            },
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
            {
                "<Tab>",
                function()
                    if vim.snippet.active({ direction = 1 }) then
                        return "<cmd>lua vim.snippet.jump(1)<cr>"
                    else
                        return "<Tab>"
                    end
                end,
                expr = true,
                mode = { "s", "i" },
            },
            {
                "<S-Tab>",
                function()
                    if vim.snippet.active({ direction = -1 }) then
                        return "<cmd>lua vim.snippet.jump(-1)<cr>"
                    else
                        return "<S-Tab>"
                    end
                end,
                expr = true,
                mode = { "s", "i" },
            },
        },
        lazy = true,
        opts = {
            preset = "helix",
            plugins = {
                registers = true,
                marks = true,
                presets = {
                    operators = true,
                    motions = true,
                    text_objects = true,
                    windows = true,
                    nav = true,
                    z = true,
                    g = true,
                },
            },
            triggers = {
                { "s", mode = "nv" },
                { "<auto>", mode = "nxsotv" },
            },
            spec = {
                { "<leader><leader>", group = "Switch Window" },
                { "<leader>A", group = "Azure" },
                { "<leader>AL", group = "Load" },
                { "<leader>AO", group = "Open" },
                { "<leader>AS", group = "Submit" },
                { "<leader>D", group = "Debug" },
                { "<leader>E", group = "Files" },
                { "<leader>G", group = "Git" },
                { "<leader>L", group = "LSP" },
                { "<leader>W", group = "Sessions" },
                { "<leader>c", group = "CMake" },
                { "<leader>f", group = "Find" },
                { "<leader>fd", group = "debug" },
                { "<leader>fg", group = "git" },
                { "<leader>fl", group = "LSP" },
                { "<leader>g", group = "Git" },
                { "<leader>i", group = "Chat" },
                { "<leader>m", group = "Man" },
                { "<leader>r", group = "Refactor" },
                { "<leader>rp", group = "Print" },
                { "<leader>rd", group = "Document" },
                { "<leader>t", group = "Test" },
                { "<leader>u", group = "Options" },
                { "<leader>x", group = "Trouble" },
            },
        },
    },
}
