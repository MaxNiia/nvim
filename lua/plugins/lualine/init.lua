local function shorten_filenames(filenames)
    local shortened = {}

    local counts = {}
    for _, file in ipairs(filenames) do
        local name = vim.fn.fnamemodify(file.filename, ":t")
        counts[name] = (counts[name] or 0) + 1
    end

    for _, file in ipairs(filenames) do
        local name = vim.fn.fnamemodify(file.filename, ":t")

        if counts[name] == 1 then
            table.insert(shortened, { filename = vim.fn.fnamemodify(name, ":t") })
        else
            table.insert(shortened, { filename = file.filename })
        end
    end

    return shortened
end

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "neovim/nvim-lspconfig",
            "nvim-neo-tree/neo-tree.nvim",
            "SmiteshP/nvim-navic",
            "AckslD/swenv.nvim",
            "catppuccin/nvim",
            "folke/noice.nvim",
        },
        lazy = true,
        event = "BufEnter",
        opts = {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
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
                        "aerial",
                    },
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                },
                lualine_c = {},
                lualine_x = {
                    {
                        function()
                            return vim.fn.ObsessionStatus("󰆓", "󱙃")
                        end,
                    },
                },
                lualine_y = {
                    {
                        function()
                            return require("noice").api.status.command.message.get_hl()
                        end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.message.has()
                        end,
                    },
                    {
                        function()
                            require("noice").api.status.command.get()
                        end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.command.has()
                        end,
                        color = { fg = "#fab387" },
                    },
                    {
                        function()
                            require("noice").api.status.mode.get()
                        end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.mode.has()
                        end,
                        color = { fg = "#fab387" },
                    },
                    {
                        function()
                            return require("noice").api.status.search.get()
                        end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.search.has()
                        end,
                        color = { fg = "#fab387" },
                    },
                    {
                        require("dap").status,
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
                        function()
                            return " " .. os.date("%R")
                        end,
                    },
                },
            },
            extensions = {
                "aerial",
                "fzf",
                "fugitive",
                "lazy",
                "neo-tree",
                "quickfix",
                "toggleterm",
                "trouble",
            },
            inactive_sections = {},
            tabline = {
                lualine_a = {
                    {
                        vim.loop.cwd,
                        type = "vim_fun",
                        padding = {
                            left = 1,
                            right = 1,
                        },
                    },
                    {
                        padding = {
                            left = 1,
                            right = 1,
                        },
                        "filename",
                    },
                },
                lualine_b = {},
                lualine_c = {
                    {
                        "navic",
                        color_correction = "dynamic",
                        navic_opts = {
                            highlight = true,
                            click = true,
                        },
                    },
                },
                lualine_x = {},
                lualine_y = {
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                    },
                    {
                        function()
                            local venv = require("swenv.api").get_current_venv()
                            if venv then
                                return string.format("🐍 %s", venv.name)
                            else
                                return ""
                            end
                        end,
                    },
                    {
                        require("plugins.lualine.copilot").get_status,
                    },
                },
                lualine_z = {
                    {
                        "tabs",
                        mode = 2,
                        use_mode_colors = true,
                    },
                },
            },
            winbar = {
                lualine_a = {
                    {
                        "fileformat",
                        separator = "",
                        padding = {
                            left = 1,
                            right = 0,
                        },
                    },
                    {
                        "filetype",
                        colored = false,
                        icon_only = true,
                        icon = { align = "right" },
                        separator = "",
                        padding = {
                            left = 1,
                            right = 0,
                        },
                    },
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                        shortng_target = 40,
                        symbols = {
                            modified = "", -- Text to show when the file is modified.
                            readonly = "", -- Text to show when the file is non-modifiable or readonly.
                            unnamed = "[No Name]", -- Text to show for unnamed buffers.
                            newfile = "[New]", -- Text to show for newly created file before first write
                        },
                    },
                },
                lualine_b = {
                    {
                        "diagnostics",
                        symbols = {
                            error = "",
                            warn = "",
                            info = "",
                            hint = "",
                        },
                        separator = "|",
                    },
                    {
                        "diff",
                        symbols = {
                            added = "",
                            modified = "",
                            removed = "",
                        },
                    },
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            inactive_winbar = {
                lualine_a = {
                    {
                        "filetype",
                        colored = false,
                        icon_only = true,
                        icon = { align = "right" },
                    },
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                        shortng_target = 40,
                        symbols = {
                            modified = "", -- Text to show when the file is modified.
                            readonly = "", -- Text to show when the file is non-modifiable or readonly.
                            unnamed = "[No Name]", -- Text to show for unnamed buffers.
                            newfile = "[New]", -- Text to show for newly created file before first write
                        },
                    },
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
}
