return {
    {
        "folke/neodev.nvim",
        lazy = true,
        ft = "lua",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            library = {
                enabled = true,
                runtime = true,
                types = true,
                plugins = true,
            },
            setup_jsonls = true,
            lspconfig = true,
            pathStrict = true,
            override = function(_, library)
                library.enabled = true
                library.plugins = true
            end,
        },
        config = function(_, opts)
            require("neodev").setup(opts)
        end,
    },
    {
        "bennypowers/nvim-regexplainer",
        lazy = true,
        events = { "BufEnter" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            filetypes = {
                "html",
                "js",
                "py",
                "cmake",
                "cpp",
                "c++",
                "c",
                "cjs",
                "mjs",
                "ts",
                "jsx",
                "tsx",
                "cjsx",
                "mjsx",
                "bash",
                "yaml",
                "json",
            },
        },
    },
    {
        "tzachar/highlight-undo.nvim",
        event = { "BufEnter" },
        dependencies = {
            "echasnovski/mini.bracketed",
        },
        opts = {
            duration = 300,
            undo = {
                hlgroup = "HighlightUndo",
                mode = "n",
                lhs = "u",
                map = "undo",
                opts = {},
            },
            redo = {
                hlgroup = "HighlightUndo",
                mode = "n",
                lhs = "<C-r>",
                map = "redo",
                opts = {},
            },
            highlight_for_count = true,
        },
        config = true,
    },
    {
        "NMAC427/guess-indent.nvim",
        lazy = true,
        event = "BufEnter",
        opts = {
            auto_cmd = true,
            override_editorconfig = false,
        },
    },
    {
        "windwp/nvim-spectre",
        keys = {
            {
                "<leader>rf",
                function()
                    require("spectre").open()
                end,
                desc = "Replace in files (Spectre)",
            },
        },
    },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = true,
        event = "BufEnter",
        config = true,
    },
    {
        "DanilaMihailov/beacon.nvim",
        lazy = true,
        event = "BufEnter",
    },
    {
        "NvChad/nvim-colorizer.lua",
        lazy = true,
        event = "BufEnter",
        opts = {
            user_default_options = {
                RRGGBBAA = true,
            },
        },
    },
    {
        "Fildo7525/pretty_hover",
        event = "LspAttach",
    },
}
