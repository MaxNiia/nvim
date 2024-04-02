return {
    {
        "AckslD/swenv.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        enabled = not vim.g.vscode,
        lazy = true,
        event = "BufEnter",
        keys = {
            {
                "<leader>V",
                function()
                    require("swenv.api").pick_venv()
                end,
                desc = "Pick venv",
                mode = "n",
            },
        },
        opts = {
            get_venvs = function(venvs_path)
                return require("swenv.api").get_venvs(venvs_path)
            end,
            venvs_path = vim.fn.expand("~/venvs"),
            post_set_venv = function()
                vim.cmd.LspRestart()
            end,
        },
    },
}
