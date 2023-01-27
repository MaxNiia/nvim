local packageList = {
    -- Always first
    "savq/paq-nvim",

    -- Impatient
    "lewis6991/impatient.nvim",

    -- Depedency
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",

    -- Which key
    "folke/which-key.nvim",

    -- Git
    "lewis6991/gitsigns.nvim",
    "sindrets/diffview.nvim",

    -- Mason
    "williamboman/mason.nvim",

    -- Mason-LSP
    "williamboman/mason-lspconfig.nvim",

    -- LSP
    "neovim/nvim-lspconfig",

    -- Linter & Formater
    "jose-elias-alvarez/null-ls.nvim",
    "jay-babu/mason-null-ls.nvim",

    -- Project
    "ahmedkhalf/project.nvim",

    -- Trouble
    "folke/trouble.nvim",

    -- Telescope
    "nvim-telescope/telescope.nvim",

    "nvim-telescope/telescope-file-browser.nvim",

    -- FZF-native
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    },

    -- Aerial
    "stevearc/aerial.nvim",

    -- Tree
    "nvim-tree/nvim-tree.lua",

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            vim.cmd "TSUpdate"
        end,
    },
    "nvim-treesitter/nvim-treesitter-context",
    "p00f/nvim-ts-rainbow",

    -- Beacon
    "DanilaMihailov/beacon.nvim",

    -- Blankline
    "lukas-reineke/indent-blankline.nvim",

    -- Autopairs
    "windwp/nvim-autopairs",

    -- Floaterm
    "voldikss/vim-floaterm",

    "onsails/lspkind-nvim",

    -- Autocompletion plugin
    "hrsh7th/nvim-cmp",
    -- LSP source for nvim-cmp
    "hrsh7th/cmp-nvim-lsp",
    -- Snippets source for nvim-cmp
    "saadparwaiz1/cmp_luasnip",
    -- Snippets pluginhrsh7th/nvim-cmp"
    "L3MON4D3/LuaSnip",

    -- Leap
    "tpope/vim-repeat",
    "ggandor/leap.nvim",

    -- Feline
    "feline-nvim/feline.nvim",

    -- Debug
    "mfussenegger/nvim-dap",

    -- Todo
    "folke/todo-comments.nvim",

    -- Notify
    "rcarriga/nvim-notify",

    -- Nui
    "MunifTanjim/nui.nvim",

    -- Noice
    "folke/noice.nvim",

    -- Dashboard
    "glepnir/dashboard-nvim",

    -- Themes
    {
        "catppuccin/nvim",
        as = "catppuccin",
    },
}

return packageList
