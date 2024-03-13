return {
    {
        "okuuva/auto-save.nvim",
        enabled = true,
        keymap = {
            "<leader>W",
            ":ASToggle<CR>",
            desc = "Toggle autosave",
            mode = "n",
        },
        opts = {
            execution_message = {
                message = function() -- message to print on save
                    return ("Saved at " .. vim.fn.strftime("%H:%M:%S"))
                end,
                dim = 0.18, -- dim the color of `message`
                cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
            },
            trigger_events = { -- See :h events
                immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
                defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
                cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
            },
            -- function that determines whether to save the current buffer or not
            -- return true: if buffer is ok to be saved
            -- return false: if it's not ok to be saved
            condition = function(buf)
                local fn = vim.fn
                local utils = require("auto-save.utils.data")

                if
                    fn.getbufvar(buf, "&modifiable") == 1
                    and utils.not_in(fn.getbufvar(buf, "&filetype"), { "alpha", "TelescopePrompt" })
                then
                    return true -- met condition(s), can save
                end
                return false -- can't save
            end,
            write_all_buffers = false, -- write all buffers when the current one meets `condition`
            debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
            callbacks = { -- functions to be executed at different intervals
                enabling = nil, -- ran when enabling auto-save
                disabling = nil, -- ran when disabling auto-save
                before_asserting_save = nil, -- ran before checking `condition`
                before_saving = nil, -- ran before doing the actual save
                after_saving = nil, -- ran after doing the actual save
            },
        },
    },
    {
        "folke/persistence.nvim",
        init = function()
            local group = vim.api.nvim_create_augroup("autosave", {})

            vim.api.nvim_create_autocmd("User", {
                pattern = "AutoSaveWritePost",
                group = group,
                callback = function(_)
                    require("persistence").save()
                end,
            })
        end,
        enabled = not vim.g.vscode,
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        opts = {
            dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
            options = { "buffers", "curdir", "terminal", "tabpages", "winsize" }, -- sessionoptions used for saving
            pre_save = nil, -- a function to call before saving the session
            save_empty = false, -- don't save if there are no open file buffers
        },
    },
}
