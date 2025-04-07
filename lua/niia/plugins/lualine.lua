local status = ""

local getActiveModeColor = function()
    local mode_color = {
        n = "lualine_a_normal",
        i = "lualine_a_insert",
        v = "lualine_a_visual",
        [""] = "lualine_a_visual",
        V = "lualine_a_visual",
        no = "lualine_a_normal",
        s = "lualine_a_visual",
        S = "lualine_a_visual",
        [""] = "lualine_a_visual",
        ic = "lualine_a_normal",
        R = "lualine_a_replace",
        Rv = "lualine_a_replace",
        c = "lualine_a_command",
        cv = "lualine_a_command",
        ce = "lualine_a_command",
        r = "lualine_a_command",
        rm = "lualine_a_command",
        ["r?"] = "lualine_a_command",
        ["!"] = "lualine_a_command",
        t = "lualine_a_terminal",
    }
    local mode = vim.fn.mode()
    return mode_color[mode]
end

local getInactiveModeColor = function()
    local mode_color = {
        n = "lualine_b_normal",
        i = "lualine_b_insert",
        v = "lualine_b_visual",
        [""] = "lualine_b_visual",
        V = "lualine_b_visual",
        no = "lualine_b_normal",
        s = "lualine_b_visual",
        S = "lualine_b_visual",
        [""] = "lualine_b_visual",
        ic = "lualine_b_normal",
        R = "lualine_b_replace",
        Rv = "lualine_b_replace",
        c = "lualine_b_command",
        cv = "lualine_b_command",
        ce = "lualine_b_command",
        r = "lualine_b_command",
        rm = "lualine_b_command",
        ["r?"] = "lualine_b_command",
        ["!"] = "lualine_b_command",
        t = "lualine_b_terminal",
    }
    local mode = vim.fn.mode()
    return mode_color[mode]
end

local getStatusLineColor = function()
    local mode_color = {
        n = "lualine_m_normal",
        i = "lualine_m_insert",
        v = "lualine_m_visual",
        [""] = "lualine_m_visual",
        V = "lualine_m_visual",
        no = "lualine_m_normal",
        s = "lualine_m_visual",
        S = "lualine_m_visual",
        [""] = "lualine_m_visual",
        ic = "lualine_m_normal",
        R = "lualine_m_replace",
        Rv = "lualine_m_replace",
        c = "lualine_m_command",
        cv = "lualine_m_command",
        ce = "lualine_m_command",
        r = "lualine_m_command",
        rm = "lualine_m_command",
        ["r?"] = "lualine_m_command",
        ["!"] = "lualine_m_command",
        t = "lualine_m_terminal",
    }
    local mode = vim.fn.mode()
    return mode_color[mode]
end

local function macro_recording()
    local mode = require("noice").api.statusline.mode.get()
    if mode then
        return string.match(mode, "^recording @.*") or ""
    end
    return ""
end

local getWinbarConfig = function(active)
    return {
        {
            "%=",
            padding = 0,
        },
        {
            "diff",
            separator = { left = "", right = "" },
            color = getInactiveModeColor,
        },
        {
            "filetype",
            icon = { align = "left" },
            colored = true,
            icon_only = true,
            color = getInactiveModeColor,
            padding = 0,
            separator = { left = "", right = "" },
        },
        {
            "filename",
            newfile_status = true,
            path = 1,
            separator = { left = "", right = "" },
            color = active and getActiveModeColor or getInactiveModeColor,
            padding = 0,
        },
        {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            separator = { left = "", right = "" },
            color = getInactiveModeColor,
        },
        {
            "%=",
            padding = 0,
        },
    }
end

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
                    left = "", --"",
                    right = "", --"",
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
                "mason",
                "trouble",
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = getWinbarConfig(false),
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = getWinbarConfig(true),
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            -- Statusline
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    {
                        function()
                            local cwd = vim.uv.cwd()
                            local home = vim.fn.expand("~")
                            cwd, _ = cwd:gsub(home, "~")
                            return cwd
                        end,
                        padding = 0,
                        color = getActiveModeColor,
                        separator = { left = "", right = "" },
                    },
                    {
                        function()
                            return status
                        end,
                        color = getInactiveModeColor,
                        separator = { left = "", right = "" },
                    },
                    {
                        "diagnostics",
                        sources = { "nvim_workspace_diagnostic" },
                        separator = { left = "", right = "" },
                        color = getInactiveModeColor,
                    },
                    {
                        "%=",
                        padding = 0,
                        color = getStatusLineColor,
                    },
                    {
                        "b:gitsigns_head",
                        icon = "",
                        separator = { left = "", right = "" },
                        color = getActiveModeColor,
                        padding = 0,
                    },
                    {
                        "%=",
                        padding = 0,
                        color = getStatusLineColor,
                    },
                    {
                        macro_recording,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.mode.has()
                        end,
                        color = getInactiveModeColor,
                        separator = { left = "", right = "" },
                    },
                    {
                        function()
                            return require("noice").api.status.command.get()
                        end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.command.has()
                        end,
                        color = getInactiveModeColor,
                        separator = { left = "", right = "" },
                    },
                    {
                        "progress",
                        color = getInactiveModeColor,
                        separator = { left = "", right = "" },
                    },
                    {
                        "location",
                        color = getInactiveModeColor,
                        separator = { left = "", right = "" },
                    },
                    {
                        "tabs",
                        mode = 2,
                        path = 0,
                        use_mode_colors = false,
                        show_modified_status = true,
                        tabs_color = {
                            active = getActiveModeColor,
                            inactive = getInactiveModeColor,
                        },
                        padding = 0,
                        symbols = {
                            modified = "",
                        },
                        separator = { left = "", right = "" },
                    },
                    {
                        "datetime",
                        style = "%H:%M",
                        color = getInactiveModeColor,
                        padding = {
                            right = 0,
                            left = 1,
                        },
                        separator = { left = "", right = "" },
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
}
