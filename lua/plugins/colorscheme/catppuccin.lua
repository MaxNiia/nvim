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
        cond = not vim.g.vscode,
        priority = 1000,
        name = "catppuccin",
        lazy = false,
        opts = {
            flavour = "mocha",
            background = {
                light = "frappe",
                dark = "mocha",
            },
            transparent_background = OPTIONS.transparent.value,
            no_italic = not OPTIONS.italic.value,
            no_bold = not OPTIONS.bold.value,
            no_underline = not OPTIONS.underline.value,
            term_colors = false,
            dim_inactive = {
                enabled = OPTIONS.dim_inactive.value,
                shade = "dark",
                percentage = 0.10,
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            color_overrides = {
                all = oled_override(OPTIONS.oled.value),
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
            integrations = {
                alpha = true,
                beacon = true,
                cmp = true,
                colorful_winsep = {
                    enabled = true,
                    color = "pink",
                },
                dashboard = true,
                diffview = true,
                gitsigns = true,
                fidget = true,
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
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
                window_picker = true,
                ts_rainbow = true,
                flash = true,
                ufo = true,
                noice = true,
                lsp_trouble = true,
                telescope = {
                    enabled = true,
                    style = "nvchad",
                },
                treesitter = true,
                treesitter_context = true,
                rainbow_delimiters = true,
                notify = true,
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
                    HighlightUndo = { bg = c.overlay0 },
                    CopilotSuggestion = { fg = c.surface1 },
                    InclineText = { fg = c.pink, bg = c.surface0, style = { "bold" } },
                    InclineTextInactive = { fg = c.text, bg = c.surface0 },
                    InclineReverse = { fg = c.surface0, bg = c.base, style = { "bold" } },
                    InclineModified = { fg = c.red, bg = c.surface0, style = { "bold", "italic" } },
                    MarkSignHL = { fg = c.yellow, style = { "bold" } },
                    NoiceCursor = { fg = c.base, bg = c.text, blend = 0 },
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
