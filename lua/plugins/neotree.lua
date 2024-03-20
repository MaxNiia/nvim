return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        enabled = function()
            return OPTIONS.neotree and not vim.g.vscode
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
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
            if vim.fn.argc() == 1 and OPTIONS.neotree then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            open_files_do_not_replace_types = {
                "oil",
                "terminal",
                "Trouble",
                "qf",
                "outline",
                "edgy",
                "Toggleterm",
            },
            source_selector = {
                winbar = true,
            },
            sources = {
                "filesystem",
                "buffers",
                "git_status",
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
                components = {
                    harpoon_index = function(config, node, state)
                        if OPTIONS.harpoon then
                            return
                        end

                        local Marked = require("harpoon.mark")
                        local path = node:get_id()
                        local succuss, index = pcall(Marked.get_index_of, path)
                        if succuss and index and index > 0 then
                            return {
                                text = string.format(" ⥤ %d", index), -- <-- Add your favorite harpoon like arrow here
                                highlight = config.highlight or "NeoTreeDirectoryIcon",
                            }
                        else
                            return {}
                        end
                    end,
                },
                renderers = {
                    file = {
                        { "icon" },
                        { "name", use_git_status_colors = true },
                        { "harpoon_index" }, --> This is what actually adds the component in where you want it
                        { "diagnostics" },
                        { "git_status", highlight = "NeoTreeDimText" },
                    },
                },
                bind_to_cwd = true,
                follow_current_file = {
                    enabled = true,
                },
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
