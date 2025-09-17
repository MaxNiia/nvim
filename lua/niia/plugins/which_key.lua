return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = function()
            local finders = {
                {
                    "<leader>s",
                    ":grep! ",
                    mode = "n",
                    desc = "Search to quickfix",
                },
                {
                    "<leader>S",
                    ":grep ",
                    mode = "n",
                    desc = "Search",
                },
                {
                    "<leader>f",
                    ":find **/",
                    mode = "n",
                    desc = "Find recursively",
                },
                {
                    "<leader>F",
                    ":find ",
                    mode = "n",
                    desc = "Find",
                },
            }
            local keymap = {
                { "H", "^", mode = { "n", "v", "o" }, desc = "End of line" },
                { "L", "$", mode = { "n", "v", "o" }, desc = "Start of line" },
                {
                    "<c-h>",
                    "<c-w>h",
                    mode = "n",
                    desc = "Go to Left Window",
                },
                {
                    "<c-j>",
                    "<c-w>j",
                    mode = "n",
                    desc = "Go to Lower Window",
                },
                {
                    "<c-k>",
                    "<c-w>k",
                    mode = "n",
                    desc = "Go to Upper Window",
                },
                {
                    "<m-.>",
                    "<esc>mzA;<esc>`z",
                    mode = "n",
                    desc = "Insert ; at end of line",
                },
                {
                    "<m-.>",
                    "<esc>mzA;<esc>`za",
                    mode = "i",
                    desc = "Insert ; at end of line",
                },
                {
                    "<m-,>",
                    "<esc>mzA,<esc>`z",
                    mode = "n",
                    desc = "Insert ; at end of line",
                },
                {
                    "<m-,>",
                    "<esc>mzA,<esc>`za",
                    mode = "i",
                    desc = "Insert ; at end of line",
                },
                {
                    "<c-l>",
                    "<c-w>l",
                    mode = "n",
                    desc = "Go to Right Window",
                },
                {
                    "<m-j>",
                    "<c-w>-",
                    mode = "n",
                    desc = "Descreas height",
                },
                {
                    "<m-k>",
                    "<c-w>+",
                    mode = "n",
                    desc = "Increase height",
                },
                {
                    "<m-l>",
                    "<c-w>>",
                    mode = "n",
                    desc = "Increase width",
                },
                {
                    "<m-h>",
                    "<c-w><",
                    mode = "n",
                    desc = "Decrease width",
                },
                {
                    "<m-J>",
                    "<c-w>=",
                    mode = "n",
                    desc = "Equal height",
                },
                {
                    "<m-K>",
                    "<c-w>_",
                    mode = "n",
                    desc = "Max height",
                },
                {
                    "<m-L>",
                    "<c-w>|",
                    mode = "n",
                    desc = "Max width",
                },
                {
                    "<",
                    "<gv",
                    mode = "v",
                },
                {
                    ">",
                    ">gv",
                    mode = "v",
                },
                {
                    "gco",
                    "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>",
                    mode = "n",
                    desc = "Add Comment Below",
                },
                {
                    "gcO",
                    "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>",
                    mode = "n",
                    desc = "Add Comment Above",
                },
                { "<esc>", "<c-\\><c-n>", mode = "t" },
                {
                    "Q",
                    "<cmd>wq<cr>",
                    mode = { "n", "v", "o" },
                    desc = "Save and quit buffer",
                },
                {
                    "<leader>Q",
                    "<cmd>%bd|e#|bd#<cr>",
                    desc = "Delete Buffer",
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
            }
            if not vim.g.finders then
                vim.list_extend(keymap, finders)
            end
            return keymap
        end,
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
                { "<leader>E", group = "Explore Dir" },
                { "<leader>b", group = "Bazel" },
                { "<leader>c", group = "CMake" },
                { "<leader>d", group = "Debug" },
                { "<leader>f", group = "Find" },
                { "<leader>g", group = "Git" },
                { "<leader>i", group = "Chat" },
                { "<leader>r", group = "Refactor" },
                { "<leader>rd", group = "Documentation" },
                { "<leader>rp", group = "Print" },
                { "<leader>s", group = "Search" },
                { "<leader>t", group = "Terminal" },
                { "<leader>u", group = "Options" },
                { "<leader>x", group = "Trouble" },
                { "gm", group = "Multicursor", mode = "v" },
                { "gr", group = "LSP" },
                { "gra", name = "Code action" },
                { "grn", name = "Rename symbol" },
            },
        },
    },
}
