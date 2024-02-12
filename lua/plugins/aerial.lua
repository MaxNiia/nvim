return {
    {
        "stevearc/aerial.nvim",
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
                max_width = { 40, 0.2 },
                width = nil,
                default_direction = "prefer_right",
                placement = "edge",
                resize_to_content = true,
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
