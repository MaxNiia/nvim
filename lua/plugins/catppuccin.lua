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
        enabled = not _G.IS_VSCODE,
        name = "catppuccin",
        opts = {
            color_overrides = {
                mocha = oled_override(_G.oled),
            },
            compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
            integrations = {
                aerial = true,
                alpha = true,
                beacon = true,
                cmp = true,
                dashboard = true,
                gitsigns = true,
                fidget = true,
                harpoon = _G.harpoon,
                illuminate = true,
                semantic_tokens = true,
                dap = true,
                dap_ui = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = true,
                },
                leap = true,
                mason = true,
                markdown = true,
                mini = true,
                neotree = true,
                window_picker = true,
                ts_rainbow = true,
                flash = true,
                ufo = true,
                lsp_trouble = true,
                telescope = {
                    enabled = true,
                    style = "nvchad",
                },
                treesitter = true,
                treesitter_context = true,
                rainbow_delimiters = true,
                notify = true,
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
                    InclineText = { fg = c.text, bg = c.surface0, style = { "bold" } },
                    InclineReverse = { fg = c.surface0, bg = c.base, style = { "bold" } },
                    InclineModified = { fg = c.blue, bg = c.surface0, style = { "bold", "italic" } },
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
