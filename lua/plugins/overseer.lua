return {
    {
        "stevearc/overseer.nvim",
        enabled = not vim.g.vscode,
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-telescope/telescope.nvim",
            "rcarriga/nvim-notify",
        },
        lazy = "BufEnter",
        cmd = {
            "OverseerRun",
            "OverseerInfo",
            "OverseerOpen",
            "OverseerBuild",
            "OverseerClose",
            "OverseerRunCmd",
            "OverseerToggle",
            "OverseerClearCache",
            "OverseerLoadBundle",
            "OverseerSaveBundle",
            "OverseerTaskAction",
            "OverseerDeleteBundle",
        },
        opts = {
            templates = { "builtin" },
        },
    },
}
