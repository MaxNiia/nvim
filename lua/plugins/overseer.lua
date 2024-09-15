return {
    {
        "stevearc/overseer.nvim",
        cond = not vim.g.vscode,
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
