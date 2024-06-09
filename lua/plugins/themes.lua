return {
    require("themes.kanagawa"),
    require("themes.catppuccin"),
    require("themes.tokyonight"),
    require("themes.nightfox"),
    {

        "lcroberts/persistent-colorscheme.nvim",
        cond = not vim.g.vscode,
        lazy = false,
        priority = 1000,
        dependencies = {
            "catppuccin/nvim",
            "rebelot/kanagawa.nvim",
            "folke/tokyonight.nvim",
            "EdenEast/nightfox.nvim",
        },
        opts = {
            colorscheme = "catppuccin",
        },
    },
}
