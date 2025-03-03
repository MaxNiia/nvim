return {
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        keys = {
            {
                "<leader>os",
                function()
                    require("persistence").load()
                end,
                mode = "n",
                desc = "Load session",
            },
            {
                "<leader>fp",
                function()
                    require("persistence").select()
                end,
                mode = "n",
                desc = "Pick session",
            },
            {
                "<leader>ol",
                function()
                    require("persistence").load({ last = true })
                end,
                mode = "n",
                desc = "Last session",
            },
            {
                "<leader>od",
                function()
                    require("persistence").stop()
                end,
                mode = "n",
                desc = "Stop session",
            },
        },
        opts = {
            branch = true,
        },
    },
}
