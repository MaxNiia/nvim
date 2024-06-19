return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        cond = not vim.g.vscode,
        opts = {
            on_colors = function(colors)
                if OPTIONS.oled.value then
                    colors.bg_dark = "#000000"
                    colors.bg = "#000000"
                    colors.terminal_black = "#000000"
                end
            end,
            on_highlights = function(hl, c)
                hl.HighlightUndo = { bg = c.bg_highlight }
                hl.CopilotSuggestion = { fg = c.comment }
                hl.InclineText = { fg = c.magenta, bg = c.bg_dark, bold = true }
                hl.InclineTextInactive = { fg = c.fg, bg = c.bg_dark }
                hl.InclineReverse = { fg = c.bg_dark, bg = c.base, bold = true }
                hl.InclineModified = { fg = c.red, bg = c.bg_dark, bold = true, italic = true }
                hl.MarkSignHL = { fg = c.yellow, bold = true }
                hl.NoiceCursor = { bg = c.fg, fg = c.bg_dark, blend = 0 }
            end,
        },
    },
}
