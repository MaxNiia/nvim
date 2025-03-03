local status = ""
local files_changed = "0"
local insertions = "0"
local deletions = "0"
local modifications = "0"
local git_status_is_busy = false

vim.api.nvim_create_autocmd({
    "BufEnter", -- When entering a buffer
    "BufFilePost", -- When a file is renamed
    "BufWritePost", -- When saving a file
    "FileChangedShellPost", -- When a file changes outside of Neovim
}, {
    callback = function()
        if git_status_is_busy then
            return
        end

        git_status_is_busy = true
        if vim.loop.os_uname().sysname == "Linux" then
            vim.system({
                "sh",
                "-c",
                "git diff | diffstat -sm",
            }, {
                text = true,
                timeout = 1000,
            }, function(obj)
                vim.defer_fn(function()
                    git_status_is_busy = false
                end, 1000)
                -- Terminated by timeout
                if obj.signal == 15 then
                    print("Timeout")
                    return
                end

                -- Other errors, presume not a git repo
                if obj.code ~= 0 then
                    print("ERROR")
                    files_changed = "0"
                    insertions = "0"
                    deletions = "0"
                    modifications = "0"
                    return
                end
                -- Extract numbers using pattern matching
                files_changed = obj.stdout:match("(%d+) files? changed") or "0"
                insertions = obj.stdout:match("(%d+) insertions?") or "0"
                deletions = obj.stdout:match("(%d+) deletions?") or "0"
                modifications = obj.stdout:match("(%d+) modifications?%(!%)") or "0"
            end)
        end
    end,
})

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

local function macro_recording()
    local mode = require("noice").api.statusline.mode.get()
    if mode then
        return string.match(mode, "^recording @.*") or ""
    end
    return ""
end

local getWinbarConfig = function(active)
    return {
        "%=",
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
        "%=",
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
                        separator = {
                            left = "",
                            right = "",
                        },
                        function()
                            return "  " .. require("dap").status()
                        end,
                        cond = function()
                            return package.loaded["dap"] and require("dap").status() ~= ""
                        end,
                        color = getInactiveModeColor,
                    },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = getInactiveModeColor,
                    },
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
                    "%=",
                    {
                        function()
                            return "" .. files_changed
                        end,
                        separator = { left = "", right = "" },
                        color = "StatusLineFiles",
                        padding = {
                            left = 0,
                            right = 1,
                        },
                    },
                    {
                        function()
                            return "+" .. insertions
                        end,
                        separator = { left = "", right = "" },
                        color = "StatusLineAdd",
                        padding = {
                            left = 0,
                            right = 1,
                        },
                    },
                    {
                        function()
                            return "~" .. modifications
                        end,
                        separator = { left = "", right = "" },
                        color = "StatusLineChange",
                        padding = {
                            left = 0,
                            right = 1,
                        },
                    },
                    {
                        function()
                            return "-" .. deletions
                        end,
                        separator = { left = "", right = "" },
                        color = "StatusLineDelete",
                        padding = {
                            left = 0,
                            right = 1,
                        },
                    },
                    {
                        "b:gitsigns_head",
                        icon = "",
                        separator = { left = "", right = "" },
                        color = getActiveModeColor,
                        padding = 0,
                    },
                    {
                        "diagnostics",
                        sources = { "nvim_workspace_diagnostic" },
                        separator = { left = "", right = "" },
                        color = getInactiveModeColor,
                    },
                    {
                        "%=",
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
