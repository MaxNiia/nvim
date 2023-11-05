local ui = require("plugins.telescope.ui")

return {

    {
        -- TODO: Look at actually using.
        "olimorris/persisted.nvim",
        keys = {
            {
                "<leader>Wl",
                "<cmd>SessionLoad<cr>",
                desc = "Load session",
            },
            {
                "<leader>WL",
                "<cmd>SessionLoadLast<cr>",
                desc = "Load last session",
            },
            {
                "<leader>Wd",
                "<cmd>SessionStop<cr>",
                desc = "Don't save",
            },
        },
        opts = {
            use_git_branch = true,
            PersistedTelescopeLoadPre = function()
                vim.api.nvim_input("<ESC>:%bd<CR>")
            end,
            PersistedTelescopeLoadPost = function(session)
                print("Loaded session " .. session.name)
            end,
            autosave = true,
            autoload = true,
            picker_opts = {
                initial_mode = "normal",
                layout_strategy = "cursor",
                layout_config = ui.layouts.small_cursor,
                enable_preview = true,
            },
        },
        config = function(_, opts)
            require("persisted").setup(opts)
        end,
    },
}
