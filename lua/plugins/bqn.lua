return {
    {
        url = "https://git.sr.ht/~detegr/nvim-bqn",
        ft = "bqn",
        init = function()
            vim.api.nvim_set_var("nvim_bqn", "bqn")
        end,
    },
    {
        "mlochbaum/BQN",
        ft = "bqn",
        init = function(plugin)
            require("lazy.core.loader").ftdetect(plugin.dir .. "/editors/vim")
        end,
        config = function(plugin)
            vim.opt.timeoutlen = 1000
            vim.opt.rtp:append(plugin.dir .. "/editors/vim")
            require("lazy.core.loader").packadd(plugin.dir .. "/editors/vim")
        end,
    },
}
