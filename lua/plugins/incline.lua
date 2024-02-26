return {
    {
        "b0o/incline.nvim",
        -- Optional: Lazy load Incline
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
                    horizontal = "center",
                },
            },
            render = function(props)
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
                local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"
                local icons = require("utils.icons")

                local function get_git_diff()
                    local signs = vim.b[props.buf].gitsigns_status_dict
                    local git_icons = icons.git
                    local labels = {}
                    local first = true
                    if signs then
                        for name, icon in pairs(git_icons) do
                            if tonumber(signs[name]) and signs[name] > 0 then
                                if first then
                                    first = false
                                    table.insert(
                                        labels,
                                        { icons.fold.separator .. " ", guifg = ft_color }
                                    )
                                end
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
                    local first = true

                    for severity, icon in pairs(severity_icons) do
                        local n = #vim.diagnostic.get(
                            props.buf,
                            { severity = vim.diagnostic.severity[string.upper(severity)] }
                        )
                        if n > 0 then
                            if first then
                                table.insert(
                                    labels,
                                    { icons.fold.separator .. " ", guifg = ft_color }
                                )
                                first = false
                            end
                            table.insert(
                                labels,
                                { icon .. n .. " ", group = "DiagnosticSign" .. severity }
                            )
                        end
                    end
                    return labels
                end

                return {
                    { icons.separator.full.right, guibg = "#000000", guifg = ft_color },
                    ft_icon and { ft_icon .. " ", guifg = "#000000", guibg = ft_color } or {},
                    { " " .. filename .. " ", gui = modified, guibg = "#1e1e2e" },
                    { get_diagnostic_label(), guibg = "#1e1e2e" },
                    { get_git_diff(), guibg = "#1e1e2e" },
                    { icons.separator.full.left, guifg = "#1e1e2e", guibg = "#000000" },
                }
            end,
        },
    },
}
