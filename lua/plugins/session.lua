return {
    {
        "okuuva/auto-save.nvim",
        cond = not vim.g.vscode,
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
                message = nil,
                dim = 0.18, -- dim the color of `message`
                cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
            },
            trigger_events = { -- See :h events
                immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
                defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
                cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
            },
            condition = require("utils.filter").saveable,
            write_all_buffers = false, -- write all buffers when the current one meets `condition`
            debounce_delay = 10000, -- saves the file at most every `debounce_delay` milliseconds
            debug = false,
        },
    },
    {
        "stevearc/resession.nvim",
        dependencies = {
            "tiagovla/scope.nvim",
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
                local ignored_buftypes = {
                    "help",
                    "nofile",
                    "prompt",
                }
                local filetype = vim.bo[bufnr].filetype
                local ignored_filetypes = {
                    "dapui_breakpoints",
                    "dapui_stacks",
                    "dapui_watches",
                    "dapui_console",
                    "dapui_scopes",
                    "dap-repl",
                }
                for _, ignored in ipairs(ignored_buftypes) do
                    if buftype == ignored then
                        return false
                    end
                end
                for _, ignored in ipairs(ignored_filetypes) do
                    if filetype == ignored then
                        return false
                    end
                end
                if
                    (vim.api.nvim_buf_get_name(bufnr) == "")
                    or (buftype ~= "" and buftype ~= "acwrite")
                then
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
        config = function(_, opts)
            local resession = require("resession")
            resession.setup(opts)
            resession.add_hook("post_load", function()
                require("incline").refresh()
                vim.cmd("tabdo wincmd =")
            end)
        end,
    },
}
