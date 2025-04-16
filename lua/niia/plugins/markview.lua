return {
    {
        "OXY2DEV/markview.nvim",
        cond = not vim.g.vscode,
        ft = { "markdown" },
        opts = {
            preview = {
                modes = { "n", "no", "c" },
            },
        },
        config = function(_, opts)
            local presets = require("markview.presets")
            opts = vim.tbl_extend("force", opts, {
                checkboxes = presets.checkboxes.nerd,
                markdown = {
                    headings = presets.headings.glow,
                    horizontal_rules = presets.horizontal_rules.thin,
                },
            })
            require("markview").setup(opts)
        end,
    },
}
