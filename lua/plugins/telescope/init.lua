local ui = require("plugins.telescope.ui")

return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = {
            "Telescope",
        },
        keys = require("plugins.telescope.keymap"),
        enabled = not vim.g.vscode,
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
            },
            "debugloop/telescope-undo.nvim",
            "folke/trouble.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "nvim-telescope/telescope-project.nvim",
            "tiagovla/scope.nvim",
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
                find_files = {},
                live_grep = {},
                grep_strings = {
                    --     initial_mode = "insert",
                    --     layout_strategy = "horizontal",
                    --     layout_config = {
                    --         horizontal = {
                    --             preview_cutoff = 150,
                    --             preview_width = 100,
                    --             height = 0.9,
                    --             width = 180,
                    --         },
                    --     },
                },
                buffers = {
                    initial_mode = OPTIONS.buffer_mode.value and "insert" or "normal",
                },
                spell_suggest = {
                    initial_mode = "normal",
                    layout_strategy = "cursor",
                    layout_config = ui.layouts.small_cursor,
                },
                lsp_references = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.lsp,
                    layout_strategy = "vertical",
                },
                lsp_incoming_calls = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.lsp,
                    layout_strategy = "vertical",
                },
                lsp_outgoing_calls = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.lsp,
                    layout_strategy = "vertical",
                },
                lsp_definitions = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.lsp,
                    layout_strategy = "vertical",
                },
                lsp_type_definitions = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.lsp,
                    layout_strategy = "vertical",
                },
                lsp_implementations = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.lsp,
                    layout_strategy = "vertical",
                },
                lsp_document_symbols = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.lsp,
                    layout_strategy = "vertical",
                },
                lsp_workspace_symbols = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.lsp,
                    layout_strategy = "vertical",
                },
                lsp_dynamic_workspace_symbols = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.lsp,
                    layout_strategy = "vertical",
                },
                diagnostics = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.lsp,
                    layout_strategy = "vertical",
                },
            },
            extensions = {
                file_browser = {
                    hijack_netrw = false,
                    display_stat = false,
                    initial_mode = "normal",
                    layout_config = ui.layouts.vertical,
                },
                fzf = {
                    fuzzy = true,
                    override_gneric_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                    layout_config = ui.layouts.vertical,
                },
                project = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.vertical,
                },
                monorepo = {
                    initial_mode = "normal",
                    layout_config = ui.layouts.vertical,
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
                    "--smart-case",
                    "--trim",
                },
                prompt_prefix = "  ",
                border = true,
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                color_devicons = true,
                borderchars = ui.borderchars,
                winblend = vim.g.neovide and 100 or 0,
                wrap_results = false,
                path_display = { truncate = 1 },
                selection_caret = "",
                entry_prefix = " ",
                initial_mode = "insert",
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "/node_modules/" },
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

            local trouble = require("trouble.sources.telescope")
            local action_state = require("telescope.actions.state")

            opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
                project = {
                    hidden_files = false,
                    sync_with_nvim_tree = false,
                    cd_scope = { "tab", "window" },
                    initial_mode = "normal",
                    on_project_selected = function(prompt_bufnr)
                        local project_actions = require("telescope._extensions.project.actions")
                        project_actions.change_working_directory(prompt_bufnr)

                        -- Set session
                        local resession = require("resession")

                        local project_path = action_state.get_selected_entry(prompt_bufnr).value
                        local pattern = "/"
                        if vim.fn.has("win32") == 1 then
                            pattern = "[\\:]"
                        end
                        local project_name = project_path:gsub(pattern, "_")
                        -- Change monorepo directory to the selected project
                        -- require("monorepo").change_monorepo(project_path)

                        local new_session = true
                        for _, session in pairs(resession.list()) do
                            if session == project_name then
                                new_session = false
                                break
                            end
                        end

                        if new_session then
                            resession.save_tab(project_path, { attach = true, notify = true })
                        else
                            resession.load(project_path, { attach = true, notify = true })
                        end

                        -- Set shada
                        local shada = require("utils.shada").get_current_shada()
                        vim.o.shadafile = shada
                        local f = io.open(shada, "r")
                        if f == nil then
                            vim.cmd.wshada()
                        end
                        pcall(vim.cmd.rshada, { bang = true })
                    end,
                },
            })

            opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
                mappings = {
                    i = {
                        ["<c-T>"] = trouble.open,
                        ["<c-s>"] = flash,
                    },
                    n = {
                        ["<c-T>"] = trouble.open,
                        ["m"] = flash,
                    },
                },
            })

            require("telescope").setup(opts)

            require("telescope.actions")
            require("telescope").load_extension("scope")
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("live_grep_args")
            require("telescope").load_extension("noice")
            require("telescope").load_extension("notify")
            require("telescope").load_extension("project")
            require("telescope").load_extension("monorepo")
            if OPTIONS.harpoon.value then
                require("telescope").load_extension("harpoon")
            end
        end,
    },
}
