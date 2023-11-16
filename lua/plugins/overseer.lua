return {
    {
        "stevearc/overseer.nvim",
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-telescope/telescope.nvim",
            -- "rcarriga/nvim-notify" NOTE: Needs to be better configured?
        },
        lazy = true,
        event = "BufEnter",
        opts = {
            templates = { "builtin", "niia" },
        },
    },
}
