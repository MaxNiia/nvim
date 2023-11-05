return {
    {
        "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
        config = function(_, _)
            local rainbow_delimiters = require("rainbow-delimiters")
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                },
            }
        end,
    },
}
