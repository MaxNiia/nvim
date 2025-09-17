local function macro_recording()
    local mode = require("noice").api.statusline.mode.get()
    if mode then
        return string.match(mode, "^recording @.*") or ""
    end
    return ""
end

return {
    {
        dependencies = {
            "AndreM222/copilot-lualine",
        },
        "nvim-lualine/lualine.nvim",
        cond = not vim.g.vscode and vim.g.statusline,
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
        end,
        opts = {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = {
                    left = "",
                    right = "",
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
                        "spectre_panel",
                        "Outline",
                        "trouble",
                        "dapui_scopes",
                        "dapui_breakpoints",
                        "dapui_stacks",
                        "dapui_console",
                        "dapui_watches",
                        "dapui_scopes",
                        "dap-repl",
                        "dashboard",
                        "terminal",
                        "lazy",
                    },
                    winbar = {
                        "spectre_panel",
                        "Outline",
                        "trouble",
                        "dapui_scopes",
                        "dapui_breakpoints",
                        "dapui_stacks",
                        "dapui_console",
                        "dapui_watches",
                        "dapui_scopes",
                        "dap-repl",
                        "dashboard",
                        "terminal",
                        "lazy",
                    },
                },
                ignore_focus = {},
                always_divide_middle = false,
                always_show_tabline = false,
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
                "mason",
                "trouble",
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            sections = {
                lualine_a = {
                    {
                        function()
                            local cwd = vim.uv.cwd()
                            local home = vim.fn.expand("~")
                            cwd, _ = cwd:gsub(home, "~")
                            return cwd
                        end,
                    },
                },
                lualine_b = {
                    {
                        "b:gitsigns_head",
                        icon = "",
                    },
                },
                lualine_c = {
                    {
                        "copilot",
                        cond = vim.g.copilot,
                    },
                    {
                        function()
                            return "  " .. require("dap").status()
                        end,
                        cond = function()
                            return package.loaded["dap"] and require("dap").status() ~= ""
                        end,
                    },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                    },
                },
                lualine_x = {
                    {
                        macro_recording,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.mode.has()
                        end,
                    },
                    {
                        "searchcount",
                        maxcount = 999,
                        timeout = 500,
                    },
                    {
                        "progress",
                    },
                    {
                        "location",
                    },
                },
                lualine_y = {
                    {
                        "datetime",
                        style = "%H:%M",
                    },
                },
                lualine_z = {
                    {
                        "tabs",
                        mode = 2,
                        path = 0,
                        show_modified_status = true,
                        symbols = {
                            modified = "",
                        },
                    },
                },
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {
                    {
                        "filetype",
                        icon = { align = "right" },
                        padding = { left = 1, right = 0 },
                        colored = true,
                        icon_only = true,
                    },
                    {
                        "filename",
                        path = 1,
                        newfile_status = true,
                        padding = { left = 0, right = 1 },
                    },
                    {
                        "fileformat",
                    },
                },
                lualine_c = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                    },
                    {
                        "diff",
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            winbar = {
                lualine_a = {},
                lualine_b = {
                    {
                        "filetype",
                        icon = { align = "right" },
                        padding = { left = 1, right = 0 },
                        colored = true,
                        icon_only = true,
                    },
                    {
                        "filename",
                        padding = { left = 0, right = 1 },
                        newfile_status = true,
                        path = 1,
                    },
                    {
                        "fileformat",
                    },
                },
                lualine_c = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                    },
                    {
                        "diff",
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
}
