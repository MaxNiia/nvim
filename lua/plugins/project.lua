return { {
    "ahmedkhalf/project.nvim",
    dependencies = {
        {
            "nvim-tree/nvim-tree.lua",
            opts = {

                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true,
                },
                view = {
                    adaptive_size = true,
                    relativenumber = true,
                    number = true,
                },
                renderer = {
                    symlink_destination = false,
                },
            },
            config = function(_, opts)
                require("nvim-tree").setup(opts)
                local wk = require("which-key")
                wk.register({
                    e = {
                        "<cmd>NvimTreeToggle<CR>",
                        "Explorer",
                    },
                    h = {
                        "<cmd>NvimTreeFindFile<CR>",
                        "Go to opened file",
                    }
                }, {
                    prefix = "<leader>",
                })
            end,
        }
    },
    lazy = true,
    opts = {
        manual_mode = false,
    },
    config = function(_, opts)
        require("project_nvim").setup(opts)
    end,
} }
