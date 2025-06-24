return {
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        dependencies = {
            -- check the installation instructions at
            -- https://github.com/folke/snacks.nvim
            "folke/snacks.nvim",
        },
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>EB",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>EC",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                "<leader>e",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig | {}
        opts = {
            open_for_directories = true,
            integrations = {
                grep_in_directory = "snacks.picker",
                grep_in_selected_files = "snacks.picker",
                picker_add_copy_relative_path_action = "snacks.picker",
                bufdelete_implementation = "snacks-if-available",
            },
        },
        init = function()
            -- vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
    },
}
