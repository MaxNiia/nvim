return {
    {
        "folke/which-key.nvim",
        keys = {
            { "H", "^", mode = { "n", "v", "o" }, desc = "End of line" },
            { "L", "$", mode = { "n", "v", "o" }, desc = "Start of line" },
            { "<c-d>", "<c-d>zz", mode = "n" },
            { "<c-u>", "<c-u>zz", mode = "n" },
            { "n", "nzzzv", mode = "n" },
            { "N", "Nzzzv", mode = "n" },
            { "<esc>", "<c-\\><c-n>", mode = "t" },
            { "<leader>P", '"_dp', mode = "x", desc = "Paste no overwrite" },
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
                "<leader>C",
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
                ["<leader>"] = {
                    name = "Switch Window",
                },
                E = { name = "Files" },
                U = { name = "Edgy" },
                T = { name = "Tabs" },
                W = { name = "Sessions" },
                r = { name = "Refactor" },
                b = { name = "Debug" },
                g = { name = "Git" },
                h = { name = "Harpoon" },
            }, { prefix = "<leader>", mode = "n" })

            wk.register({
                c = { name = "ChatGPT" },
                t = { name = "Terminal" },
                f = {
                    name = "Find",
                    d = { name = "Debug" },
                    g = { name = "Git" },
                    l = { name = "LSP" },
                    t = { name = "Terminal" },
                    m = { name = "Man" },
                },
                x = { name = "Trouble" },
            }, { prefix = "<leader>", mode = { "n", "v" } })
        end,
    },
}
