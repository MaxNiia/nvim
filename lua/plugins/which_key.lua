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
            { "<leader>P", '"_dp', mode = {"v", "x"}, desc = "Paste and keep" },
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
                F = { name = "Config" },
                b = { name = "Debug" },
                h = { name = "Harpoon" },
            }, { prefix = "<leader>", mode = "n" })

            if OPTIONS.neotree.value then
                wk.register({
                    H = {
                        name = "Git",
                        b = { name = "Branch" },
                    },
                }, { prefix = "<leader>", mode = "n" })
            else
                wk.register({
                    f = {
                        g = { name = "Git" },
                    },
                    g = {
                        name = "Git",
                        b = { name = "Branch" },
                    },
                }, { prefix = "<leader>", mode = "n" })
            end

            if OPTIONS.toggleterm.value then
                wk.register({
                    t = { name = "Terminal" },
                    T = { name = "Test" },
                }, { prefix = "<leader>", mode = "n" })
            else
                wk.register({
                    t = { name = "Test" },
                }, { prefix = "<leader>", mode = "n" })
            end

            wk.register({
                b = { name = "Debug" },
                c = { name = "ChatGPT" },
                r = { name = "Rename" },
                f = {
                    name = "Find",
                    d = { name = "Debug" },
                    l = { name = "LSP" },
                    t = { name = "Terminal" },
                    m = { name = "Man" },
                },
                x = { name = "Trouble" },
            }, { prefix = "<leader>", mode = { "n", "v" } })
        end,
    },
}
