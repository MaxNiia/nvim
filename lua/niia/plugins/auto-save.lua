return {
    {
        "okuuva/auto-save.nvim",
        event = { "InsertEnter", "BufLeave" },
        keys = {
            -- {
            --     "<leader>Wa",
            --     "<cmd>ASToggle<CR>",
            --     desc = "Toggle autosave",
            --     mode = "n",
            -- },
        },
        opts = {
            enabled = true,
            trigger_events = { -- See :h events
                immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
                defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
                cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
            },
            write_all_buffers = true, -- write all buffers when the current one meets `condition`
            debounce_delay = 10000, -- saves the file at most every `debounce_delay` milliseconds
            debug = false,
        },
    },
}
