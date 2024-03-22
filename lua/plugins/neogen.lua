return {
    {
        "danymat/neogen",
        keys = {
            {
                "<leader>rd",
                function()
                    require("neogen").generate()
                end,
                mode = "n",
                desc = "Function annotation",
            },
            {
                "<leader>rc",
                function()
                    require("neogen").generate({ type = "class" })
                end,
                mode = "n",
                desc = "Class annotation",
            },
            {
                "<leader>rf",
                function()
                    require("neogen").generate({ type = "file" })
                end,
                mode = "n",
                desc = "File annotation",
            },
        },
        opts = {
            enabled = true,
            input_after_comment = true,
            snippet_engine = "luasnip",
        },
    },
}
