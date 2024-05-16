local icons = require("utils.icons").todo
return {
    {
        "MaxNiia/nvim-unception",
        lazy = false,
        init = function()
            -- Optional settings go here!
            vim.g.unception_delete_replaced_buffer = false
            vim.g.unception_open_buffer_in_new_tab = false
            vim.g.unception_enable_flavor_text = true

            if OPTIONS.toggleterm.value then
                vim.api.nvim_create_autocmd("User", {
                    pattern = "UnceptionEditRequestReceived",
                    callback = function()
                        -- Toggle the terminal off.
                        if vim.bo.filetype == "toggleterm" then
                            require("toggleterm").toggle_all(true)
                        end
                    end,
                })
            end
        end,
    },
    {
        "max397574/better-escape.nvim",
        opts = {
            mapping = { "jk", "jj" },
            timeout = vim.o.timeoutlen,
            clear_empty_lines = false,
            keys = "<Esc>",
        },
    },
    {
        "tiagovla/scope.nvim",
        dependencies = {
            "akinsho/toggleterm.nvim",
        },
        opts = {
            hooks = {
                pre_tab_leave = function()
                    if OPTIONS.toggleterm.value then
                        require("toggleterm").toggle_all(true)
                    end
                end,
                post_tab_enter = function()
                    require("incline").refresh()
                    local current_session = require("resession").get_current()
                    if current_session ~= nil and current_session ~= "" then
                        vim.cmd.tcd(current_session)
                    end
                end,
            },
        },
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        dependencies = {
            "catppuccin/nvim",
        },
        event = { "WinNew" },
        opts = {
            hi = {
                fg = vim.api.nvim_get_hl(0, { name = "WinSep" })["foreground"],
            },
        },
    },
    {
        "folke/neodev.nvim",
        ft = "lua",
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
                "<leader>rr",
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
        },
        config = function(_, opts)
            opts = vim.tbl_extend("force", opts, {
                select = {
                    telescope = {
                        initial_mode = "normal",
                        layout_stategy = "cursor",
                    },
                },
            })
            require("dressing").setup(opts)
        end,
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
            filetypes = {
                "*",
                "!minifiles",
            },
        },
    },
}
