return {
    {
        "echasnovski/mini.ai",
        version = false,
        event = "BufEnter",
        config = function(_, opts)
            require("mini.ai").setup(opts)
        end,
    },
    {
        "echasnovski/mini.bracketed",
        version = false,
        event = "BufEnter",
        config = function(_, opts)
            require("mini.bracketed").setup(opts)
        end,
    },
    {
        "echasnovski/mini.comment",
        version = false,
        event = "BufEnter",
        opts = {
            options = {
                custom_commentstring = nil,
                ignore_blank_line = true,
            },
        },
        config = function(_, opts)
            require("mini.comment").setup(opts)
        end,
    },
    {
        "echasnovski/mini.surround",
        version = false,
        event = "BufEnter",
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end,
    },
    {
        "echasnovski/mini.cursorword",
        version = false,
        event = "BufEnter",
        config = function(_, opts)
            require("mini.cursorword").setup(opts)
        end,
    },
    {
        "echasnovski/mini.pairs",
        version = false,
        event = "BufEnter",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },
    require("plugins.mini.files")
}
