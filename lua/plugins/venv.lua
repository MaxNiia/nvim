return {
    {
        "linux-cultist/venv-selector.nvim",
        branch = "regexp", -- This is the regexp branch, use this for the new version
        config = function()
            require("venv-selector").setup()
        end,
        keys = {
            { "<leader>V", "<cmd>VenvSelect<cr>" },
        },
    },
}
