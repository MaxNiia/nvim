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
        },
        lazy = true,
        opts = {
            plugins = {
                registers = true,
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)

            wk.register({
                ["<leader>"] = { name = "Switch Window" },
                E = { name = "Files" },
                G = { name = "Git" },
                b = { name = "Debug" },
                h = { name = "Harpoon" },
            }, { prefix = "<leader>", mode = "n" })

            wk.register({}, { prefix = "<leader>", mode = "n" })

            wk.register({
                D = { name = "Debug" },
                W = { name = "Sessions" },
                c = { name = "CMake" },
                g = { name = "Hunks" },
                f = {
                    name = "Telescope",
                    d = { name = "Debug" },
                    g = { name = "Git" },
                    l = { name = "LSP" },
                    m = { name = "Man" },
                    t = { name = "Terminal" },
                },
                i = { name = "Chat" },
                r = { name = "Refactor" },
                t = { name = "Test" },
                w = { name = "Wiki" },
                x = { name = "Trouble" },
            }, { prefix = "<leader>", mode = { "n", "v" } })
        end,
    },
}
