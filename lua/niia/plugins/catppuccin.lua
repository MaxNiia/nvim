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
        priority = 1000,
        name = "catppuccin",
        opts = {
            flavour = "auto",
            background = {
                light = "frappe",
                dark = "mocha",
            },
            transparent_background = false,
            no_italic = false,
            no_bold = false,
            no_underline = false,
            term_colors = false,
            dim_inactive = {
                enabled = true,
                shade = "dark",
                percentage = 0.15,
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            color_overrides = {
                all = oled_override(vim.g.cat_oled),
            },
            styles = {
                comments = { "bold" },
                properties = { "italic" },
                functions = { "italic", "bold" },
                keywords = { "italic" },
                operators = { "bold" },
                conditionals = { "bold" },
                loops = { "bold" },
                booleans = { "bold", "italic" },
                numbers = {},
                types = { "italic" },
                strings = {},
                variables = {},
            },
            default_integrations = true,
            integrations = {
                -- cmp = true,
                blink_cmp = true,
                grug_far = true,
                diffview = true,
                gitsigns = true,
                semantic_tokens = true,
                snacks = true,
                dap = true,
                dap_ui = true,
                mason = true,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
                flash = true,
                ufo = true,
                noice = true,
                lsp_trouble = true,
                treesitter = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                        ok = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                        ok = { "underline" },
                    },
                    inlay_hints = {
                        background = false,
                    },
                },
                which_key = true,
            },
            custom_highlights = function(c)
                return {
                    HighlightUndo = { bg = c.overlay0 },
                    MarkSignHL = { fg = c.yellow, style = { "bold" } },
                    StatusLineFileName = { fg = c.base, bg = c.pink, style = { "bold" } },
                    StatusLineFiles = { fg = c.pink, bg = c.surface0, style = { "bold" } },
                    StatusLineAdd = { fg = c.green, bg = c.surface0, style = { "bold" } },
                    StatusLineChange = { fg = c.yellow, bg = c.surface0, style = { "bold" } },
                    StatusLineDelete = { fg = c.red, bg = c.surface0, style = { "bold" } },
                    FzfLuaHeaderBind = { fg = c.rosewater },
                    FzfLuaHeaderText = { fg = c.maroon },
                    FzfLuaPathColNr = { fg = c.sky },
                    FzfLuaPathLineNr = { fg = c.green },
                    FzfLuaBufName = { fg = c.mauve },
                    FzfLuaBufNr = { fg = c.rosewater },
                    FzfLuaBufFlagCur = { fg = c.maroon },
                    FzfLuaBufFlagAlt = { fg = c.sky },
                    FzfLuaTabTitle = { fg = c.sapphire },
                    FzfLuaTabMarker = { fg = c.rosewater },
                    FzfLuaLiveSym = { fg = c.maroon },
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
