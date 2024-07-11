return {
    {
        "mvllow/modes.nvim",
        event = "VeryLazy",
        dependency = {
            "nvim-lualine/lualine.nvim",
        },
        opts = {
            colors = {
                copy = vim.api.nvim_get_hl(0, { name = "lualine_a_normal" })["bg"],
                delete = vim.api.nvim_get_hl(0, { name = "lualine_a_replace" })["bg"],
                insert = vim.api.nvim_get_hl(0, { name = "lualine_a_insert" })["bg"],
                visual = vim.api.nvim_get_hl(0, { name = "lualine_a_visual" })["bg"],
            },
            line_opacity = 0.15,
            set_number = false,
            set_cursorline = false,
        },
    },
}
