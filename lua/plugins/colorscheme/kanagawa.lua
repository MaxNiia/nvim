local oled_override = function(bool)
    if bool then
        return {
            sumiInk0 = "#000000",
            sumiInk1 = "#000000",
            sumiInk2 = "#000000",
            sumiInk3 = "#000000",
        }
    else
        return {}
    end
end

return {

    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        cond = not vim.g.vscode,
        priority = 1000,
        opts = {
            compile = true,
            undercurl = OPTIONS.underline.value,
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = OPTIONS.transparent.value,
            dimInactive = OPTIONS.dim_inactive.value,
            terminalColors = true,
            colors = {
                palette = oled_override(OPTIONS.oled.value),
                theme = {
                    wave = {},
                    lotus = {},
                    dragon = {},
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
            overrides = function(c) -- add/modify highlights
                return {
                    HighlightUndo = { bg = c.sumiInk4 },
                    CopilotSuggestion = { fg = c.fujiGray },
                    MarkSignHL = { fg = c.roninYellow, bold = true },
                    NoiceCursor = { bg = c.fujiWhite, fg = c.sumiInk1, blend = 0 },
                }
            end,
            theme = "wave", -- Load "wave" theme when 'background' option is not set
            background = { -- map the value of 'background' option to a theme
                dark = "wave", -- try "dragon" !
                light = "lotus",
            },
        },
    },
}
