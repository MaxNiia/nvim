return {
    {
        "RRethy/vim-illuminate",
        lazy = true,
        events = { "BufEnter" },
        config = function(_, _)
            require("illuminate").configure({
                providers = {
                    "lsp",
                    "treesitter",
                    "regex",
                },
                delay = 100,
            })
        end,
    },
}
