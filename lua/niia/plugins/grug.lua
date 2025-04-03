return {
    {
        "MagicDuck/grug-far.nvim",
        commands = {
            "GrugFar",
        },
        keys = {
            {
                "<leader>fs",
                function()
                    require("grug-far").open({})
                end,
                desc = "Search and replace",
                mode = { "n", "v" },
            },
            {
                "<leader>fa",
                function()
                    require("grug-far").open({ engine = "astgrep" })
                end,
                desc = "Astgrep",
                mode = { "n", "v" },
            },
        },
        config = true,
    },
}
