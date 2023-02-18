return {
    {
        "nvim-neorg/neorg",
        ft = "norg",
        config = true,
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = true,
    },
    {

        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        config = true,
    },
    {
        "rcarriga/nvim-notify",
        lazy = true,
        event = "BufEnter",
        config = true,
    },
    {

        "folke/todo-comments.nvim",
        lazy = true,
        event = "BufEnter",
        config = true,
    },
    {
        "tpope/vim-repeat",
        lazy = true,
        event = "BufEnter",
    },
    {
        "ggandor/leap.nvim",
        lazy = true,
        event = "BufEnter",
        config = true,
    },
    {
        "DanilaMihailov/beacon.nvim",
        lazy = true,
        event = "BufEnter",
    },
}
