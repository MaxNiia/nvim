return {
    {
        "AckslD/swenv.nvim",
        enabled = not _G.IS_VSCODE,
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        lazy = true,
        event = "BufEnter",
        opts = {
            get_venvs = function(venvs_path)
                return require("swenv.api").get_venvs(venvs_path)
            end,
            venvs_path = vim.fn.expand("~/venvs"),
            post_set_venv = function()
                vim.cmd.LspRestart()
            end,
        },
        config = function(_, opts)
            require("swenv").setup(opts)
            local wk = require("which-key")
            wk.register({
                V = {
                    function()
                        require("swenv.api").pick_venv()
                    end,
                    "Pick venv",
                },
            }, { prefix = "<leader>", mode = "n" })
        end,
    },
}
