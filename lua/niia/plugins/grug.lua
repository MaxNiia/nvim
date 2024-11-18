return {
    {
        "MagicDuck/grug-far.nvim",
        keys = {
            {
                "<leader>rr",
                function()
                    require("grug-far").grug_far({})
                end,
                desc = "Search and replace",
                mode = { "n", "v" },
            },
            {
                "<leader>ra",
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
