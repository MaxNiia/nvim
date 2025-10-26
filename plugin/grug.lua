require("grug-far").setup()
vim.keymap.set(
    { "n", "v" },
    "<leader>fe",
    function()
        require("grug-far").open({})
    end,
    { desc = "Search and replace", }
)
vim.keymap.set(
    { "n", "v" },
    "<leader>fa",
    function()
        require("grug-far").open({ engine = "astgrep" })
    end,
    { desc = "Astgrep", }
)
