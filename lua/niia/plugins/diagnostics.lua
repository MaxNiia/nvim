return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        opts = {
            preset = "classic",
            options = {
                multiple_diag_under_cursor = true,
                multilines = true,
                use_icons_from_diagnostic = true,
                virt_texts = { priority = 101 },
            },
            -- signs = {
            --     left = " ",
            --     right = " ",
            --     arrow = "    ",
            --     up_arrow = "    ",
            --     vertical = " │",
            --     vertical_end = " └",
            -- },
            -- blend = {
            --     factor = 0.22,
            -- },
        },
        config = function(_, opts)
            -- opts = vim.tbl_extend("force", opts, {
            --     hi = {
            --         mixing_color = vim.o.background == "light" and "#e7e7e7" or "None",
            --     },
            -- })

            require("tiny-inline-diagnostic").setup(opts)
        end,
    },
}
