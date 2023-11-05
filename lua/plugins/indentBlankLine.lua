return {{
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = "BufEnter",
    opts = {
        show_current_context = true,
        show_current_context_start = true,
    },
    config = function(_, opts)
        vim.opt.list = true

        require("indent_blankline").setup(opts)
    end,
}}
