return {{
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    config = function(_, _)
        require("theme.catppuccin")
    end,
}}
