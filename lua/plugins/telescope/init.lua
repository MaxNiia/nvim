local ui = require("plugins.telescope.ui")

return {
    {
        "nvim-telescope/telescope.nvim",
        keys = require("plugins.telescope.keymap"),
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
            },
            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "mfussenegger/nvim-dap",
            "ThePrimeagen/harpoon",
        },
        lazy = true,
        opts = {
            pickers = {
                colorscheme = {
                    initial_mode = "normal",
                    layout_strategy = "cursor",
                    layout_config = ui.layouts.small_cursor,
                    enable_preview = true,
                },
                live_grep = {},
                grep_strings = {
                    initial_mode = "normal",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            preview_cutoff = 150,
                            preview_width = 80,
                            height = 0.9,
                            width = 180,
                        },
                    },
                },
                buffers = {
                    initial_mode = "normal",
                },
                spell_suggest = {
                    initial_mode = "normal",
                    layout_strategy = "cursor",
                    layout_config = ui.layouts.small_cursor,
                },
                lsp_references = {
                    layout_config = ui.layouts.lsp,
                },
                lsp_incoming_calls = {
                    layout_config = ui.layouts.lsp,
                },
                lsp_outgoing_calls = {
                    layout_config = ui.layouts.lsp,
                },
                lsp_definitions = {
                    layout_config = ui.layouts.lsp,
                },
                lsp_type_definitions = {
                    layout_config = ui.layouts.lsp,
                },
                lsp_implementations = {
                    layout_config = ui.layouts.lsp,
                },
                lsp_document_symbols = {
                    layout_config = ui.layouts.lsp,
                },
                lsp_workspace_symbols = {
                    layout_config = ui.layouts.lsp,
                },
                lsp_dynamic_workspace_symbols = {
                    layout_config = ui.layouts.lsp,
                },
                diagnostics = {
                    layout_config = ui.layouts.lsp,
                },
            },
            extensions = {
                file_browser = {
                    hijack_netrw = false,
                    display_stat = false,
                    initial_mode = "normal",
                },
                fzf = {
                    fuzzy = true,
                    override_gneric_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                monorepo = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.small_cursor,
                },
                live_grep_args = {
                    auto_quoting = true,
                },
            },
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "-S",
                    "--color=never",
                    "--column",
                    "--line-number",
                    "--no-heading",
                    "--with-filename",
                },
                prompt_prefix = "   ",
                border = true,
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                color_devicons = true,
                borderchars = ui.borderchars,
                winblend = 0,
                wrap_results = false,
                path_display = { truncate = 1 },
                selection_caret = "",
                entry_prefix = " ",
                initial_mode = "insert",
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "node_modules" },
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                prompt_title = "",
                results_title = "",
                preview_title = "",
                layout_strategy = "vertical",
                buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                mappings = {
                    n = { ["q"] = require("telescope.actions").close },
                },
                layout_config = {
                    prompt_position = "top",
                    width = 0.87,
                    height = 0.80,
                    center = ui.layouts.center,
                    cursor = ui.layouts.cursor,
                    horizontal = ui.layouts.horizontal,
                    vertical = ui.layouts.vertical,
                    flex = ui.layouts.flex,
                },
            },
        },
        config = function(_, opts)
            local function flash(prompt_bufnr)
                require("flash").jump({
                    pattern = "^",
                    label = { after = { 0, 0 } },
                    search = {
                        mode = "search",
                        exclude = {
                            function(win)
                                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype
                                    ~= "TelescopeResults"
                            end,
                        },
                    },
                    action = function(match)
                        local picker =
                            require("telescope.actions.state").get_current_picker(prompt_bufnr)
                        picker:set_selection(match.pos[1] - 1)
                    end,
                })
            end

            local trouble = require("trouble.providers.telescope")

            opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
                mappings = {
                    i = {
                        ["<c-T>"] = trouble.open_with_trouble,
                        ["<c-s>"] = flash,
                    },
                    n = {
                        ["<c-T>"] = trouble.open_with_trouble,
                        ["m"] = flash,
                    },
                },
            })

            local telescope = require("telescope").setup(opts)

            require("telescope.actions")
            require("telescope").load_extension("harpoon")
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("projects")
            require("telescope").load_extension("notify")
            require("telescope").load_extension("noice")
            require("telescope").load_extension("dap")
            require("telescope").load_extension("refactoring")
            require("telescope").load_extension("live_grep_args")
        end,
    },
}
