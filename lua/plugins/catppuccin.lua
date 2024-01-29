local oled_override = function(bool)
    if bool then
        return {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
        }
    else
        return {}
    end
end

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            color_overrides = {
                mocha = oled_override(_G.oled),
            },
            compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
            integrations = {
                beacon = true,
                cmp = true,
                dashboard = true,
                gitsigns = true,
                fidget = true,
                harpoon = _G.harpoon,
                illuminate = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = true,
                },
                leap = true,
                mason = true,
                markdown = true,
                mini = true,
                neotree = true,
                flash = true,
                telescope = {
                    enabled = true,
                    style = "nvchad",
                },
                treesitter = true,
                treesitter_context = true,
                rainbow_delimiters = true,
                navic = {
                    enabled = true,
                    custom_bg = "NONE", -- "lualine" will set background to mantle
                },
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                which_key = true,
            },
            custom_highlights = function(c)
                return {
                    -- Comment = { fg = c.rosewater },
                    HighlightUndo = { bg = c.overlay0 },
                    CopilotSuggestion = { fg = c.surface1 },
                    DiffviewFilePanelPath = { fg = c.sapphire },
                }
            end,
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            local colors = require("catppuccin.palettes").get_palette()
            colors.none = "NONE"
        end,
    },
}
