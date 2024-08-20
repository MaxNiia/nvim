return {
    {
        "OXY2DEV/markview.nvim",
        lazy = true,
        ft = { "markdown" },
        opts = {
            modes = { "n", "no", "c" },
            hybrid_modes = { "n" },
            callbacks = {
                on_enable = function(_, win)
                    vim.wo[win].conceallevel = 2
                    vim.wo[win].concealcursor = "c"
                end,
            },
        },
    },
}
