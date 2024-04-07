return {
    {
        "serenevoid/kiwi.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            {
                name = "work",
                path = vim.fn.expand("~/work"),
            },
            {
                name = "personal",
                path = vim.fn.expand("~/personal"),
            },
        },
        keys = {
            {
                "<leader>ww",
                ':lua require("kiwi").open_wiki_index("work")<cr>',
                desc = "Open index of work wiki",
            },
            {
                "<leader>wp",
                ':lua require("kiwi").open_wiki_index("personal")<cr>',
                desc = "Open index of personal wiki",
            },
            { "<leader>T", ':lua require("kiwi").todo.toggle()<cr>', desc = "Toggle Markdown Task" },
        },
        lazy = true,
    },
}
