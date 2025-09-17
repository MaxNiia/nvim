return {
    {
        "mikavilpas/yazi.nvim",
        cond = (not vim.g.vscode) and vim.g.yazi and vim.g.browser,
        event = "VeryLazy",
        dependencies = {
            "folke/snacks.nvim",
        },
        keys = {
            {
                "<leader>EB",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
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
