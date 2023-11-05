return {
    {
        "AckslD/swenv.nvim",
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
            post_set_venv = nil,
        },
        config = function(_, opts)
            require("swenv").setup(opts)
        end,
    },
}
