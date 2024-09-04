local prev_mode = false

return {
    {
        "folke/twilight.nvim",
    },
    {
        "folke/zen-mode.nvim",
        cond = not vim.g.vscode,
        keys = {
            { "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" },
        },
        event = "BufEnter",
        opts = {
            window = {
                backdrop = 0.95,
                width = 120,
                height = 1,
            },
            plugins = {
                -- disable some global vim options (vim.o...)
                -- comment the lines to not apply the options
                options = {
                    enabled = true,
                },
                twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
                wezterm = {
                    enabled = not vim.g.neovide,
                    -- can be either an absolute font size or the number of incremental steps
                    font = "+4", -- (10% increase per step)
                },
                neovide = {
                    enabled = vim.g.neovide,
                    font = "+4",
                },
            },
            on_open = function(
                _ --[[win]]
            )
                prev_mode = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
                vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
            end,
            on_close = function()
                vim.lsp.inlay_hint.enable(prev_mode, { bufnr = 0 })
            end,
        },
    },
}
