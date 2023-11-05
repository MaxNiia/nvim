return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
            integrations = {
                aerial = true,
                beacon = true,
                cmp = true,
                dashboard = true,
                gitsigns = true,
                fidget = true,
                harpoon = true,
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
                noice = true,
                notify = true,
                which_key = true,
            },
            custom_highlights = function(c)
                return {
                    -- Comment = { fg = c.rosewater }, For BQN.
                    -- LineNr = { fg = c.pink },
                    -- HarpoonInactive = { bg = c.mantle, fg = c.blue, bold = true },
                    -- HarpoonRightSeparator = { bg = c.blue, fg = c.mantle },
                    -- HarpoonActive = { bg = c.blue, fg = c.mantle, bold = true },
                    -- HarpoonLeftSeparator = { bg = c.mantle, fg = c.blue },
                    HighlightUndo = { bg = c.overlay0 },
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
