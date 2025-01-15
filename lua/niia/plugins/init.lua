local icons = require("niia.utils.icons").todo
return {
    {
        "m00qek/baleia.nvim",
        version = "*",
        config = function()
            vim.g.baleia = require("baleia").setup({})

            -- Command to colorize the current buffer
            vim.api.nvim_create_user_command("BaleiaColorize", function()
                vim.g.baleia.once(vim.api.nvim_get_current_buf())
            end, { bang = true })

            -- Command to show logs
            vim.api.nvim_create_user_command(
                "BaleiaLogs",
                vim.g.baleia.logger.show,
                { bang = true }
            )
        end,
    },
    {
        "MaxNiia/nvim-unception",
        lazy = false,
        init = function()
            -- Optional settings go here!
            vim.g.unception_delete_replaced_buffer = false
            vim.g.unception_open_buffer_in_new_tab = false
            vim.g.unception_enable_flavor_text = false
        end,
    },
    {
        "NvChad/showkeys",
        cmd = "ShowkeysToggle",
        opts = {
            timeout = 3,
            maxkeys = 5,
            show_count = true,
        },
    },
    {
        "max397574/better-escape.nvim",
        opts = {
            mappings = {
                i = {
                    j = {
                        -- These can all also be functions
                        k = "<Esc>",
                        j = "<Esc>",
                    },
                },
                c = {
                    j = {
                        k = "<Esc>",
                        j = "<Esc>",
                    },
                },
                t = {
                    j = {
                        k = "<C-\\><C-n>",
                        j = "<C-\\><C-n>",
                    },
                },
                v = {
                    j = {
                        k = "<Esc>",
                    },
                },
                s = {
                    j = {
                        k = "<Esc>",
                    },
                },
            },
            timeout = vim.o.timeoutlen,
            clear_empty_lines = false,
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "mini.files", words = { "MiniFiles" } },
                { path = "lazy.nvim", words = { "LazyVim" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {
            file = {
                [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
                ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
            },
            filetype = {
                dotenv = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = "BufEnter",
        keys = {
            {
                "<leader>st",
                function()
                    Snacks.picker.todo_comments()
                end,
                desc = "Todo",
            },
            {
                "<leader>sT",
                function()
                    Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
                end,
                desc = "Todo/Fix/Fixme",
            },
        },
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
        "OXY2DEV/foldtext.nvim",
        lazy = false,
        config = true,
    },
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {
            lang = {
                astro = "<!-- %s -->",
                c = "// %s",
                cpp = "// %s",
                css = "/* %s */",
                gleam = "// %s",
                glimmer = "{{! %s }}",
                glsl = "// %s",
                graphql = "# %s",
                handlebars = "{{! %s }}",
                hcl = "# %s",
                html = "<!-- %s -->",
                ini = "; %s",
                php = "// %s",
                rego = "# %s",
                rescript = "// %s",
                sql = "-- %s",
                svelte = "<!-- %s -->",
                terraform = "# %s",
                tsx = {
                    _ = "// %s",
                    call_expression = "// %s",
                    comment = "// %s",
                    jsx_attribute = "// %s",
                    jsx_element = "{/* %s */}",
                    jsx_fragment = "{/* %s */}",
                    spread_element = "// %s",
                    statement_block = "// %s",
                },
                javascript = {
                    _ = "// %s",
                    call_expression = "// %s",
                    comment = "// %s",
                    jsx_attribute = "// %s",
                    jsx_element = "{/* %s */}",
                    jsx_fragment = "{/* %s */}",
                    spread_element = "// %s",
                    statement_block = "// %s",
                },
                twig = "{# %s #}",
                typescript = "// %s",
                vim = '" %s',
                vue = "<!-- %s -->",
            },
        },
    },
    {
        "tpope/vim-abolish",
    },
    {
        "tpope/vim-dispatch",
    },
}
