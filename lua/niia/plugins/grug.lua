return {
    {
        "MagicDuck/grug-far.nvim",
        keys = {
            {
                "<leader>fs",
                function()
                    require("grug-far").grug_far({})
                end,
                desc = "Search and replace",
                mode = { "n", "v" },
            },
            {
                "<leader>fa",
                function()
                    require("grug-far").grug_far({ engine = "astgrep" })
                end,
                desc = "Astgrep",
                mode = { "n", "v" },
            },
        },
        config = true,
    },
}
