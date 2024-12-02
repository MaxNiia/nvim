local status = ""
return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end

            if vim.g.enable_copilot then
                -- Copilot
                local api = require("copilot.api")
                local copilot_icon = require("niia.utils.icons").kinds.Copilot
                local offline_icon = require("niia.utils.icons").progress.offline
                local done_icon = require("niia.utils.icons").progress.done
                local pending_icon = require("niia.utils.icons").progress.pending
                api.register_status_notification_handler(function(data)
                    -- customize your message however you want
                    if data.status == "Normal" then
                        status = done_icon
                    elseif data.status == "InProgress" then
                        status = pending_icon
                    else
                        status = offline_icon
                    end
                    status = copilot_icon .. " " .. status
                end)
            end
        end,
        opts = {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = {
                    left = "",
                    right = "",
                },
                section_separators = {

                    left = "",
                    right = "",
                },
                disabled_filetypes = {
                    statusline = {
                        "dashboard",
                        "lazy",
                        "Mason",
                    },
                    winbar = {
                        "spectre_panel",
                        "Outline",
                        "Trouble",
                        "dapui_scopes",
                        "dapui_breakpoints",
                        "dapui_stacks",
                        "dapui_console",
                        "dapui_watches",
                        "dapui_scopes",
                        "dap-repl",
                        "dashboard",
                        "terminal",
                        "toggleterm",
                        "lazy",
                    },
                },
                ignore_focus = {},
                always_divide_middle = false,
                always_show_tabline = true,
                globalstatus = vim.o.laststatus == 3,
                refresh = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                },
            },
            extensions = {
                "fzf",
                "fugitive",
                "lazy",
                "quickfix",
                "toggleterm",
                "mason",
                "trouble",
            },
            inactive_winbar = {
                lualine_a = {
                    {
                        "filename",
                        newfile_status = true,
                        path = 1,
                        separator = "",
                    },
                    {
                        "filetype",
                        icon = { align = "left" },
                        colored = true,
                        icon_only = true,
                    },
                },
                lualine_b = {
                    {
                        "diff",
                    },
                    {
                        "diagnostics",
                    },
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            winbar = {
                lualine_a = {
                    {
                        "filename",
                        newfile_status = true,
                        path = 1,
                        separator = "",
                    },
                    {
                        "filetype",
                        icon = { align = "left" },
                        colored = false,
                        icon_only = true,
                    },
                },
                lualine_b = {
                    {
                        "diff",
                    },
                    {
                        "diagnostics",
                    },
                },
                lualine_c = {
                    {
                        "aerial",
                        colored = true,
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            -- Statusline
            sections = {
                lualine_a = {
                    {
                        function()
                            local cwd = vim.uv.cwd()
                            local home = vim.fn.expand("~")
                            cwd, _ = cwd:gsub(home, "~")
                            return cwd
                        end,
                        padding = {
                            left = 1,
                            right = 1,
                        },
                    },
                    {
                        "b:gitsigns_head",
                        icon = "",
                    },
                },
                lualine_b = {
                    {
                        function()
                            return "  " .. require("dap").status()
                        end,
                        cond = function()
                            return package.loaded["dap"] and require("dap").status() ~= ""
                        end,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        function()
                            return status
                        end,
                        cond = function()
                            return vim.g.enable_copilot
                        end,
                    },
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    {
                        function()
                            return require("noice").api.status.command.get()
                        end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.command.has()
                        end,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        function()
                            return require("noice").api.status.mode.get()
                        end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.mode.has()
                        end,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        "progress",
                    },
                    {
                        "location",
                    },
                },
                lualine_z = {
                    {
                        "tabs",
                        mode = 2,
                        path = 0,
                        use_mode_colors = true,
                        show_modified_status = true,
                        symbols = {
                            modified = "",
                        },
                    },
                    {
                        "datetime",
                        style = "%H:%M",
                    },
                },
            },
        },
    },
}
