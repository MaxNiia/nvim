return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        init = function()
            vim.opt.list = true
        end,
        opts = {
            char = "│",
            filetype_exclude = { "help", "alpha", "dashboard", "Nvim-tree", "Trouble", "lazy" },
            show_current_context = true,
            show_current_context_start = true,
        },
    },
}
