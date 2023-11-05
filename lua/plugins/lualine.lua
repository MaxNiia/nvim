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
        },
        lazy = true,
        event = "BufEnter",
        init = function()
            vim.api.nvim_set_hl(0, "HarpoonActive", { link = "lualine_a_normal" })
            vim.api.nvim_set_hl(0, "HarpoonInactive", { link = "lualine_a_inactive" })
            vim.api.nvim_set_hl(0, "HarpoonRightSeparator", { link = "lualine_a_normal" })
            vim.api.nvim_set_hl(0, "HarpoonLeftSeparator", { link = "lualine_a_inactive" })
        end,
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
                            local original_tabs = require("harpoon").get_mark_config().marks
                            local tabs = shorten_filenames(original_tabs)
                            local tabline = ""
                            local current_tab_index = -10
                            return vim.fn.ObsessionStatus("󰆓", "󱙃")
                        end,
                    },
                },
                lualine_y = {
                    {
                        function()
                            return require("noice").api.status.command.get()
                        end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.command.has()
                        end,
                    },
                    {
                        function()
                            return require("noice").api.status.mode.get()
                        end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.mode.has()
                        end,
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
                            local original_tabs = require("harpoon").get_mark_config().marks
                            local tabs = shorten_filenames(original_tabs)
                            local tabline = ""
                            local current_tab_index = -10

                            for i, tab in ipairs(original_tabs) do
                                if
                                    string.match(vim.fn.bufname(), tab.filename)
                                    or vim.fn.bufname() == tab.filename
                                then
                                    current_tab_index = i
                                end
                            end

                            for i, tab in ipairs(original_tabs) do
                                local is_current = current_tab_index == i
                                local label = tabs[i].filename
                                local separator = "%*"
                                local l_a_sep = ""
                                local l_i_sep = ""
                                local r_a_sep = ""
                                local r_i_sep = ""
                                if current_tab_index == i + 1 then
                                    separator = separator .. "%#HarpoonInactive#" .. " " .. "%*"
                                    separator = separator
                                        .. "%#HarpoonLeftSeparator#"
                                        .. r_a_sep
                                        .. "%*"
                                elseif current_tab_index == i then
                                    separator = separator .. "%#HarpoonActive#" .. " " .. "%*"
                                    separator = separator
                                        .. "%#HarpoonRightSeparator#"
                                        .. r_a_sep
                                        .. "%*"
                                else
                                    separator = separator .. "%#HarpoonInactive#" .. r_i_sep .. "%*"
                                end

                                if is_current then
                                    -- if current_tab_index == 1 then
                                    -- 	tabline = tabline .. "%#HarpoonInactive#" .. "" .. "%*"
                                    -- end
                                    tabline = tabline .. "%*" .. "%#HarpoonActive#"
                                else
                                    tabline = tabline .. "%*" .. "%#HarpoonInactive#"
                                end

                                tabline = tabline .. " " .. label
                                if i < #tabs then
                                    tabline = tabline .. "%*" .. separator .. "%T"
                                else
                                    tabline = tabline .. " " .. "%*"
                                end
                            end
                            return tabline
                        end,
                        padding = 0,
                        separator = "",
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
                lualine_a = {},
                -- lualine_b = {} -- Tabline
                lualine_c = {
                    {
                        "navic",
                        color_correction = "dynamic",
                        navic_opts = {
                            highlight = true,
                            click = true,
                        },
                        padding = {
                            left = 1,
                            right = 0,
                        },
                    },
                },
                -- lualine_x = {}, Tabline
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
                },
                lualine_z = {
                    {
                        vim.loop.cwd,
                        type = "vim_fun",
                    },
                    {
                        function()
                            return " " .. os.date("%R")
                        end,
                    },
                },
            },
            winbar = {
                lualine_a = {
                    {
                        "filetype",
                        colored = false,
                        icon_only = true,
                        icon = { align = "right" },
                        separator = "",
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
