return {
    {
        "folke/zen-mode.nvim",
        cond = not vim.g.vscode,
        keys = {
            { "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" },
        },
        event = "BufEnter",
        opts = {
            window = {
                backdrop = 0.85,
                width = 150,
                height = 1,
            },
            plugins = {
                -- disable some global vim options (vim.o...)
                -- comment the lines to not apply the options
                options = {
                    enabled = true,
                },
                twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
                wezterm = {
                    enabled = true,
                    -- can be either an absolute font size or the number of incremental steps
                    font = "+4", -- (10% increase per step)
                },
            },
        },
    },
}
