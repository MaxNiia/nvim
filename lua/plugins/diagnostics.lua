return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        opts = {
            signs = {
                left = "",
                right = "",
                diag = "●",
                arrow = "    ",
                up_arrow = "    ",
                vertical = " │",
                vertical_end = " └",
            },
            options = {
                multiple_diag_under_cursor = true,
                multilines = OPTIONS.multi_line_diagnostics.value,
                virt_texts = { priority = 50 },
            },
        },
        config = function(_, opts)
            opts = vim.tbl_extend("force", opts, {
                hi = {
                    mixing_color = vim.o.background == "light" and "#e7e7e7" or "None",
                },
            })

            require("tiny-inline-diagnostic").setup(opts)
        end,
    },
}
