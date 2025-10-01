local icons = require("niia.utils.icons").todo
return {
    {
        "jacksonhvisuals/nvim-treesitter-cpp-tools",
        cond = not vim.g.vscode,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        -- Optional: Configuration
        opts = function()
            local options = {
                preview = {
                    quit = "q", -- optional keymapping for quit preview
                    accept = "<tab>", -- optional keymapping for accept preview
                },
                header_extension = "h", -- optional
                source_extension = "cpp", -- optional
                custom_define_class_function_commands = { -- optional
                    TSCppImplWrite = {
                        output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
                    },
                    --[[
                <your impl function custom command name> = {
                    output_handle = function (str, context) 
                        -- string contains the class implementation
                        -- do whatever you want to do with it
                    end
                }
                ]]
                },
            }
            return options
        end,
        -- End configuration
        config = true,
    },
    {
        "hat0uma/csvview.nvim",
        cond = not vim.g.vscode,
        ---@module "csvview"
        ---@type CsvView.Options
        opts = {
            parser = { comments = { "#", "//" } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    },
    {
        "samjwill/nvim-unception",
        lazy = false,
        cond = not vim.g.vscode,
        init = function()
            -- Optional settings go here!
            vim.g.unception_delete_replaced_buffer = false
            vim.g.unception_open_buffer_in_new_tab = true
            vim.g.unception_enable_flavor_text = false
        end,
    },
    {
        "folke/lazydev.nvim",
        cond = not vim.g.vscode,
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "mini.files", words = { "MiniFiles" } },
                { path = "lazy.nvim", words = { "LazyVim" } },
                { "nvim-dap-ui" },
                { "nvim-neotest" },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "folke/todo-comments.nvim",
        event = "BufEnter",
        keys = vim.g.finders and {
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
        } or {},
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

            search = { pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]] },
            highlight = { pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]] },
        },
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
        lazy = false,
        cond = not vim.g.vscode,
        -- keys = {
        -- crs coerce to snake_case
        -- crm coerce to MixedCase
        -- crc coerce to camelCase
        -- cru coerce to UPPER_CASE
        -- cr- coerce to dash-case
        -- cr. coerce to dot.case
        -- }
    },
    {
        "tpope/vim-dispatch",
        lazy = false,
        cond = not vim.g.vscode,
    },
    {
        "tpope/vim-fugitive",
        lazy = false,
        cond = not vim.g.vscode,
        keys = {
            {
                "<leader>gc",
                "<cmd>G commit<cr>",
                desc = "Git commit",
            },
            {
                "<leader>G",
                "<cmd>G<cr>",
                desc = "Git status",
            },
        },
    },
    {
        "bkad/CamelCaseMotion",
        lazy = false,
        init = function()
            vim.cmd([[
                let g:camelcasemotion_key = "<localleader>"
            ]])
        end,
    },
    {
        "habamax/vim-godot",
        cond = not vim.g.vscode,
    },
    {
        "monaqa/dial.nvim",
        config = function(_, opts)
            local augend = require("dial.augend")
            vim.keymap.set("n", "<C-a>", function()
                require("dial.map").manipulate("increment", "normal")
            end)
            vim.keymap.set("n", "<C-x>", function()
                require("dial.map").manipulate("decrement", "normal")
            end)
            vim.keymap.set("n", "g<C-a>", function()
                require("dial.map").manipulate("increment", "gnormal")
            end)
            vim.keymap.set("n", "g<C-x>", function()
                require("dial.map").manipulate("decrement", "gnormal")
            end)
            vim.keymap.set("x", "<C-a>", function()
                require("dial.map").manipulate("increment", "visual")
            end)
            vim.keymap.set("x", "<C-x>", function()
                require("dial.map").manipulate("decrement", "visual")
            end)
            vim.keymap.set("x", "g<C-a>", function()
                require("dial.map").manipulate("increment", "gvisual")
            end)
            vim.keymap.set("x", "g<C-x>", function()
                require("dial.map").manipulate("decrement", "gvisual")
            end)
            require("dial.config").augends:register_group({
                default = {
                    augend.constant.alias.alpha,
                    augend.constant.alias.Alpha,
                    augend.constant.alias.bool,
                    augend.integer.alias.decimal_int,
                    augend.date.new({
                        pattern = "%Y-%m-%d",
                        default_kind = "day",
                        only_valid = true,
                    }),
                    augend.date.new({
                        pattern = "%m-%d",
                        default_kind = "day",
                        only_valid = true,
                    }),

                    require("dial.augend").constant.new({
                        elements = { "and", "or" },
                        word = true,
                    }),
                    require("dial.augend").constant.new({
                        elements = { "True", "False" },
                        word = true,
                    }),
                },
            })
        end,
    },
}
