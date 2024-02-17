return {
    {
        "stevearc/overseer.nvim",
        enabled = not _G.IS_VSCODE,
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-telescope/telescope.nvim",
            -- "rcarriga/nvim-notify" NOTE: Needs to be better configured?
        },
        lazy = true,
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
            templates = { "builtin", "niia" },
        },
    },
}
