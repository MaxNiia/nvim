return {
    {
        "imNel/monorepo.nvim",
        cond = not vim.g.vscode,
        keys = {
            {
                "<leader>wt",
                function()
                    require("monorepo").toggle_project()
                end,
                desc = "Toggle project",
                mode = "n",
            },
            {
                "<leader>wn",
                function()
                    require("monorepo").next_project()
                end,
                desc = "Next Project",
                mode = "n",
            },
            {
                "<leader>wp",
                function()
                    require("monorepo").previous_project()
                end,
                desc = "Previous Project",
                mode = "n",
            },
        },
        opts = {
            silent = false,
            autoload_telescope = true,
            data_path = vim.fn.stdpath("data"),
        },
    },
}
