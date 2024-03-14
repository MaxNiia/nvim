return {
    {
        "okuuva/auto-save.nvim",
        enabled = true,
        keymap = {
            "<leader>Wa",
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
        {
            "stevearc/resession.nvim",
            keymap = {
                {
                    "<leader>Ws",
                    function()
                        require("resession").save_tab(
                            vim.fn.getcwd(),
                            { dir = "dirsession", notify = true }
                        )
                    end,
                    mode = "n",
                    desc = "Save session",
                },
                {
                    "<leader>Wl",
                    function()
                        require("resession").load(
                            vim.fn.getcwd(),
                            { dir = "dirsession", notify = true }
                        )
                    end,
                    mode = "n",
                    desc = "Load session",
                },
                {
                    "<leader>Wd",
                    function()
                        require("resession").delete(
                            vim.fn.getcwd(),
                            { dir = "dirsession", notify = true }
                        )
                    end,
                    mode = "n",
                    desc = "Delete session",
                },
            },
            init = function()
                local resession = require("resession")
                vim.api.nvim_create_autocmd("VimEnter", {
                    callback = function()
                        -- Only load the session if nvim was started with no args
                        if vim.fn.argc(-1) == 0 then
                            -- Save these to a different directory, so our manual sessions don't get polluted
                            resession.load(
                                vim.fn.getcwd(),
                                { dir = "dirsession", silence_errors = true }
                            )
                        end
                    end,
                })
                vim.api.nvim_create_autocmd("VimLeavePre", {
                    callback = function()
                        resession.save_all()
                    end,
                })
            end,
            opts = {
                options = {
                    "binary",
                    "bufhidden",
                    "buflisted",
                    "cmdheight",
                    "diff",
                    "filetype",
                    "modifiable",
                    "previewwindow",
                    "readonly",
                    "scrollbind",
                    "winfixheight",
                    "winfixwidth",
                },
                tab_buf_filter = function(tabpage, bufnr)
                    local dir = vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tabpage))
                    -- ensure dir has trailing /
                    dir = dir:sub(-1) ~= "/" and dir .. "/" or dir
                    return vim.startswith(vim.api.nvim_buf_get_name(bufnr), dir)
                end,
                autosave = {
                    enabled = true,
                    interval = 60,
                    notify = true,
                },
            },
        },
    },
}
