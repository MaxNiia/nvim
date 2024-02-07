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
        "lewis6991/hover.nvim",
        opts = {
            init = function()
                -- Require providers
                require("hover.providers.lsp")
                -- require('hover.providers.gh')
                -- require('hover.providers.gh_user')
                -- require('hover.providers.jira')
                -- require('hover.providers.man')
                -- require('hover.providers.dictionary')
            end,
            preview_opts = {
                border = "single",
            },
            -- Whether the contents of a currently open hover window should be moved
            -- to a :h preview-window when pressing the hover keymap.
            preview_window = false,
            title = true,
            mouse_providers = {
                "LSP",
            },
            mouse_delay = 1000,
        },
        lazy = false,
        config = function(_, opts)
            require("hover").setup(opts)
            -- Mouse support
            vim.keymap.set(
                "n",
                "<MouseMove>",
                require("hover").hover_mouse,
                { desc = "hover.nvim (mouse)" }
            )
            vim.o.mousemoveevent = true

            -- vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
            vim.keymap.set(
                "n",
                "gK",
                require("hover").hover_select,
                { desc = "hover.nvim (select)" }
            )
            vim.keymap.set("n", "<C-p>", function()
                require("hover").hover_switch("previous")
            end, { desc = "hover.nvim (previous source)" })
            vim.keymap.set("n", "<C-n>", function()
                require("hover").hover_switch("next")
            end, { desc = "hover.nvim (next source)" })
        end,
    },
}
