return {
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            char = "│",
            filetype_exclude = { "help", "alpha", "dashboard", "Nvim-tree", "Trouble", "lazy" },
            show_current_context = true,
            show_current_context_start = true,
        },
        config = function(_, opts)
            vim.opt.list = true

            require("indent_blankline").setup(opts)
        end,
    },
}
