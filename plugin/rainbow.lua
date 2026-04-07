local rainbow = require("rainbow-delimiters")

require("rainbow-delimiters.setup").setup({
    strategy = {
        [""] = rainbow.strategy["global"],
    },
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
    },
    highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
    },
})

vim.keymap.set("n", "<leader>ur", function()
    vim.cmd("RainbowDelimitersToggle")
end, { desc = "Toggle Rainbow Delimiters" })
