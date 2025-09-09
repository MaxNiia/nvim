return {
    {
        "OXY2DEV/markview.nvim",
        cond = not vim.g.vscode,
        ft = { "markdown" },
        opts = {
            preview = {
                modes = { "no", "c" },
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
            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                --- Change these to whatever file extensions you want to run this on.
                pattern = { "*.md" },
                callback = function()
                    --- Use `splitToggle` if you use `dev`.
                    vim.cmd("Markview splitClose")
                    vim.cmd("Markview splitOpen")
                end,
            })
            require("markview").setup(opts)
        end,
    },
}
