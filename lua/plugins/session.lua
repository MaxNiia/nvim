return {
    {
        "okuuva/auto-save.nvim",
        enabled = not vim.g.vscode,
        event = "BufEnter",
        keys = {
            {
                "<leader>Wa",
                "<cmd>ASToggle<CR>",
                desc = "Toggle autosave",
                mode = "n",
            },
        },
        init = function()
            local group = vim.api.nvim_create_augroup("autosave", {})

            vim.api.nvim_create_autocmd("User", {
                pattern = "AutoSaveWritePost",
                group = group,
                callback = function(
                    _ --[[opts]]
                )
                    local current_session = require("resession").get_current()
                    if current_session ~= nil and current_session ~= "" then
                        require("resession").save(vim.fn.getcwd(), { notify = true })
                    end
                end,
            })
        end,
        opts = {
            enabled = true,
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
                    vim.api.nvim_buf_is_loaded(buf)
                    and fn.getbufvar(buf, "&modifiable") == 1
                    and utils.not_in(fn.getbufvar(buf, "&filetype"), {
                        "alpha",
                        "TelescopePrompt",
                        "minifiles",
                    })
                then
                    return true -- met condition(s), can save
                end
                return false -- can't save
            end,
            write_all_buffers = false, -- write all buffers when the current one meets `condition`
            debounce_delay = 1000, -- saves the file at most every `debounce_delay` milliseconds
            debug = false,
        },
    },
    {
        "stevearc/resession.nvim",
        dependencies = {
            "tiagovla/scope.nvim",
            "catppuccin/nvim",
        },
        keys = {
            {
                "<leader>Ws",
                function()
                    require("resession").save(vim.fn.getcwd(), { notify = true })
                end,
                mode = "n",
                desc = "Save session",
            },
            {
                "<leader>Wl",
                function()
                    local resession = require("resession")

                    local project_path = vim.fn.getcwd()
                    local pattern = "/"
                    if vim.fn.has("win32") == 1 then
                        pattern = "[\\:]"
                    end
                    local project_name = project_path:gsub(pattern, "_")
                    local new_session = true
                    for _, session in pairs(resession.list()) do
                        if session == project_name then
                            new_session = false
                            break
                        end
                    end
                    if new_session then
                        resession.save(project_path, { attach = false, notify = true })
                    else
                        resession.load(project_path, { attach = false, notify = true })
                    end
                    local shada = require("utils.shada").get_current_shada()
                    vim.o.shadafile = shada
                    local f = io.open(shada, "r")
                    if f == nil then
                        vim.cmd.wshada()
                    end
                    pcall(vim.cmd.rshada, { bang = true })
                end,
                mode = "n",
                desc = "Load session",
            },
            {
                "<leader>Wd",
                function()
                    require("resession").delete(vim.fn.getcwd(), { notify = true })
                end,
                mode = "n",
                desc = "Delete session",
            },
        },
        init = function()
            local resession = require("resession")
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
                "winhighlight",
            },
            autosave = {
                enabled = false,
                interval = 60,
                notify = true,
            },
            tab_buf_filter = function(tabpage, bufnr)
                local dir = vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tabpage))
                -- ensure dir has trailing /
                dir = dir:sub(-1) ~= "/" and dir .. "/" or dir
                return vim.startswith(vim.api.nvim_buf_get_name(bufnr), dir)
            end,
            buf_filter = function(bufnr)
                local buftype = vim.bo[bufnr].buftype
                if buftype == "help" then
                    return true
                end
                if buftype ~= "" and buftype ~= "acwrite" then
                    return false
                end
                if vim.api.nvim_buf_get_name(bufnr) == "" then
                    return false
                end

                -- this is required, since the default filter skips nobuflisted buffers
                return true
            end,
            extensions = {
                scope = {
                    enable_in_tab = true,
                },
            },
        },
    },
}
