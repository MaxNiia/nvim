return {
    {
        "b0o/incline.nvim",
        event = "VeryLazy",

        opts = {
            ignore = {
                buftypes = "special",
                filetypes = {
                    "gitcommit",
                    "git",
                },
                floating_wins = true,
                unlisted_buffers = true,
                wintypes = "special",
            },
            window = {
                placement = {
                    vertical = "top",
                    horizontal = "left",
                },
                padding = { left = 0, right = 1 },
            },
            hide = {
                cursorline = "focused_win",
            },
            render = function(props)
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":p:.")
                local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
                local modified = vim.bo[props.buf].modified
                local icons = require("utils.icons")

                local function get_git_diff()
                    local signs = vim.b[props.buf].gitsigns_status_dict
                    local git_icons = icons.git
                    local labels = {}
                    if signs then
                        for name, icon in pairs(git_icons) do
                            if tonumber(signs[name]) and signs[name] > 0 then
                                table.insert(
                                    labels,
                                    { icon .. " " .. signs[name] .. " ", group = "Diff" .. name }
                                )
                            end
                        end
                    end
                    return labels
                end
                local function get_diagnostic_label()
                    local icons_diagnostics = icons.diagnostics
                    local severity_icons = {
                        error = icons_diagnostics.Error,
                        warn = icons_diagnostics.Warn,
                        info = icons_diagnostics.Info,
                        hint = icons_diagnostics.Hint,
                    }
                    local labels = {}

                    for severity, icon in pairs(severity_icons) do
                        local n = #vim.diagnostic.get(
                            props.buf,
                            { severity = vim.diagnostic.severity[string.upper(severity)] }
                        )
                        if n > 0 then
                            table.insert(
                                labels,
                                { icon .. n .. " ", group = "DiagnosticSign" .. severity }
                            )
                        end
                    end
                    return labels
                end

                return {
                    ft_icon and { " " .. ft_icon .. " ", guifg = "bg", guibg = ft_color } or {},
                    {
                        " " .. filename .. " ",
                        group = modified and "InclineModified" or "InclineText",
                    },
                    { get_diagnostic_label(), group = "InclineText" },
                    { get_git_diff(), group = "InclineText" },
                    { icons.separator.full.left, group = "InclineReverse" },
                }
            end,
        },
    },
}
