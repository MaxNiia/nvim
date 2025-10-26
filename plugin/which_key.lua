require("which-key").setup({
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
        { "s",      mode = "nv" },
        { "<auto>", mode = "nxsotv" },
    },
    spec = {
        { "<leader><leader>", group = "Smart fpicker" },
        { "<leader>E",        group = "Explore Dir" },
        { "<leader>f",        group = "Find" },
        { "<leader>g",        group = "Git" },
        { "<leader>s",        group = "Search" },
        { "<leader>t",        group = "Terminal" },
        { "<leader>u",        group = "Options" },
        { "gm",               group = "Multicursor",  mode = {"n", "v"} },
        { "gr",               group = "LSP" },
        { "gra",              name = "Code action" },
        { "grn",              name = "Rename symbol" },
    },
})
