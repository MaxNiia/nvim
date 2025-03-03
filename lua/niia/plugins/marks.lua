return {
    {
        "chentoast/marks.nvim",
        lazy = false,
        opts = {
            default_mappings = true,
            cyclic = true,
            refresh_interval = 150,
            builtin_marks = {
                "'",
                "<",
                ">",
                ".",
            },
            sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        },
    },
}
