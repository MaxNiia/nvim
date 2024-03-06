local icons = require("utils.icons").todo
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
        "Pocco81/auto-save.nvim",
        enabled = true,
        keymap = {
            "<leader>W",
            ":ASToggle<CR>",
            desc = "Toggle autosave",
            mode = "n",
        },
        execution_message = {
            message = function() -- message to print on save
                return ("Saved at " .. vim.fn.strftime("%H:%M:%S"))
            end,
            dim = 0.18, -- dim the color of `message`
            cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
            trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
            -- function that determines whether to save the current buffer or not
            -- return true: if buffer is ok to be saved
            -- return false: if it's not ok to be saved
            condition = function(buf)
                local fn = vim.fn
                local utils = require("auto-save.utils.data")

                if
                    fn.getbufvar(buf, "&modifiable") == 1
                    and utils.not_in(fn.getbufvar(buf, "&filetype"), {})
                then
                    return true -- met condition(s), can save
                end
                return false -- can't save
            end,
            write_all_buffers = false, -- write all buffers when the current one meets `condition`
            debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
            callbacks = { -- functions to be executed at different intervals
                enabling = nil, -- ran when enabling auto-save
                disabling = nil, -- ran when disabling auto-save
                before_asserting_save = nil, -- ran before checking `condition`
                before_saving = nil, -- ran before doing the actual save
                after_saving = nil, -- ran after doing the actual save
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
        opts = {
            open_cmd = "vnew",
            live_update = true,
        },
    },
    {
        "stevearc/dressing.nvim",
        lazy = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            input = {
                insert_only = false,
            },
            select = {
                telescope = {
                    initial_mode = "normal",
                    layout_stategy = "cursor",
                },
            },
        },
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
        opts = {
            signs = true,
            keywords = {
                FIX = {
                    icon = " ",
                    color = "error",
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                },
                TODO = { icon = icons.todo .. " ", color = "info" },
                HACK = { icon = icons.hack .. " ", color = "warning" },
                WARN = { icon = icons.warn .. " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = icons.perf .. " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = icons.note .. " ", color = "hint", alt = { "INFO" } },
                TEST = {
                    icon = icons.test .. " ",
                    color = "test",
                    alt = { "TESTING", "PASSED", "FAILED" },
                },
            },
        },
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
