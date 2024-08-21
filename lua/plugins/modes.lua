local to_rgb = function(value)
    local out = ("#%06x"):format(value)
    print(out)
    return out
end

return {
    {
        "mvllow/modes.nvim",
        event = "BufEnter",
        dependency = {
            "nvim-lualine/lualine.nvim",
        },
        opts = {
            line_opacity = 0.35,
            set_number = false,
            set_cursorline = false,
        },
        config = function(_, opts)
            opts.colors = {
                copy = to_rgb(vim.api.nvim_get_hl(0, { name = "lualine_a_normal" })["bg"]),
                delete = to_rgb(vim.api.nvim_get_hl(0, { name = "lualine_a_replace" })["bg"]),
                insert = to_rgb(vim.api.nvim_get_hl(0, { name = "lualine_a_insert" })["bg"]),
                visual = to_rgb(vim.api.nvim_get_hl(0, { name = "lualine_a_visual" })["bg"]),
            }
            require("modes").setup(opts)
        end,
    },
}
