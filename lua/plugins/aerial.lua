return {
    {
        "stevearc/aerial.nvim",
        enabled = not vim.g.vscode,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                "<leader>A",
                "<cmd>AerialToggle!<cr>",
                desc = "Toggle Aerial",
            },
        },
        opts = {
            backends = { "treesitter", "lsp", "markdown", "man" },
            layout = {
                max_width = { 800, 1 },
                width = nil,
                default_direction = "prefer_right",
                placement = "edge",
                resize_to_content = false,
            },
            attach_mode = "global",
            on_attach = function(bufnr)
                vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", { buffer = bufnr })
                vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", { buffer = bufnr })
            end,
            autojump = true,
        },
    },
}
