require("catppuccin").setup(
    {
        flavour = "auto",
        auto_integrations = true,
        background = {
            light = "frappe",
            dark = "mocha",
        },
        transparent_background = false,
        float = {
            transparent = false,
            solid = false,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        term_colors = false,
        dim_inactive = {
            enabled = false,
            shade = "dark",
            percentage = 0.15,
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
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
        },
    }
)

local colors = require("catppuccin.palettes").get_palette()
colors.none = "NONE"
