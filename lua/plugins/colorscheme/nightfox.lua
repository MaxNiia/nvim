return {
    {
        "EdenEast/nightfox.nvim",
        cond = not vim.g.vscode,
        lazy = false,
        priority = 1000,
        opts = {
            options = {
                -- Compiled file's destination location
                compile_path = vim.fn.stdpath("cache") .. "/nightfox",
                compile_file_suffix = "_compiled", -- Compiled file suffix
                transparent = OPTIONS.transparent.value,
                terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                dim_inactive = OPTIONS.dim_inactive.value,
                module_default = true, -- Default enable value for modules
                colorblind = {
                    enable = OPTIONS.colorblind.value,
                    simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
                    severity = {
                        protan = OPTIONS.colorblind_protan.value, -- Severity [0,1] for protan (red)
                        deutan = OPTIONS.colorblind_deutan.value, -- Severity [0,1] for deutan (green)
                        tritan = OPTIONS.colorblind_tritan.value, -- Severity [0,1] for tritan (blue)
                    },
                },
                styles = { -- Style to be applied to different syntax groups
                    comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
                    conditionals = "NONE",
                    constants = "NONE",
                    functions = "NONE",
                    keywords = "NONE",
                    numbers = "NONE",
                    operators = "NONE",
                    strings = "NONE",
                    types = "NONE",
                    variables = "NONE",
                },
                inverse = { -- Inverse highlight for different types
                    match_paren = false,
                    visual = false,
                    search = false,
                },
                modules = { -- List of various plugins and additional options
                },
            },
            palettes = {
                all = OPTIONS.oled.value
                        and {

                            bg1 = "#000000", -- Black background
                            bg0 = "#1d1d2b", -- Alt backgrounds (floats, statusline, ...)
                            bg3 = "#121820", -- 55% darkened from stock
                            sel0 = "#131b24", -- 55% darkened from stock
                        }
                    or {},
            },
            specs = {},
            groups = {},
        },
    },
}
