return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        -- TODO: Move to neotree v3
        branch = "v2.x",
        enabled = function()
            return _G.neotree
        end,
        dependencies = {
            {
                "s1n7ax/nvim-window-picker",
                lazy = true,
                opts = {
                    filter_rules = {
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { "neo-tree", "neo-tree-popup", "notify" },
                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { "terminal", "quickfix" },
                        },
                    },
                    autoselect_one = true,
                    include_current = false,
                    use_winbar = "never",
                },
                config = true,
            },
        },
        cmd = "Neotree",
        keys = {
            {
                "<leader>g",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            {
                "<leader>G",
                function()
                    require("neo-tree.command").execute({ toggle = true })
                end,
                desc = "Explorer NeoTree",
                remap = true,
            },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            -- if vim.fn.argc() == 1 then
            --     local stat = vim.loop.fs_stat(vim.fn.argv(0))
            --     if stat and stat.type == "directory" then
            --         require("neo-tree")
            --     end
            -- end
        end,
        opts = {
            open_files_do_not_replace_types = {
                "oil",
                "terminal",
                "Trouble",
                "qf",
                "outline",
                "edgy",
            },
            source_selector = {
                winbar = false,
            },
            sources = {
                "filesystem",
                "buffers",
                "git_status",
                "document_symbols",
            },
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function(_)
                        vim.cmd([[
                            setlocal relativenumber
                        ]])
                    end,
                },
            },
            filesystem = {
                bind_to_cwd = true,
                follow_current_file = true,
                hijack_netrw_behavior = "disabled",
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                    ["S"] = "split_with_window_picker",
                    ["s"] = "vsplit_with_window_picker",
                },
            },
        },
    },
}