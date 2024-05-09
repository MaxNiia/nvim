local icons = require("utils.icons").fold

local only_buffer = function()
    -- Return false if number of buffers is less than 2
    return #vim.fn.getbufinfo({ buflisted = 1 }) > 1
end

local get_trouble_filter = function(filter_mode, pos)
    return function(_, win)
        return vim.w[win].trouble
            and vim.w[win].trouble.position == pos
            and vim.w[win].trouble.mode == filter_mode
            and vim.w[win].trouble.type == "split"
            and vim.w[win].trouble.relative == "editor"
            and not vim.w[win].trouble_preview
    end
end

return {
    "folke/edgy.nvim",
    event = "VimEnter",
    cond = not vim.g.vscode,
    opts = {
        animate = {
            enabled = false,
            cps = 600,
        },
        left = {
            {
                ft = "DiffviewFiles",
                size = { width = 50 },
            },
            {
                ft = "OverseerList",
                command = "OverseerOpen",
                size = { width = 80 },
            },
            {
                ft = "copilot-chat",
                size = { width = 120 },
            },
            {
                ft = "trouble",
                title = "LSP",
                size = { width = 50 },
                filter = get_trouble_filter("lsp", "right"),
            },
            {
                ft = "trouble",
                title = "LSP Declarations",
                size = { width = 50 },
                filter = get_trouble_filter("lsp_declarations", "right"),
            },
            {
                ft = "trouble",
                title = "LSP Definitions",
                size = { width = 50 },
                filter = get_trouble_filter("lsp_definitions", "right"),
            },
            {
                ft = "trouble",
                title = "LSP Symbols",
                size = { width = 50 },
                filter = get_trouble_filter("lsp_document_symbols", "right"),
            },
            {
                ft = "trouble",
                title = "LSP Implementations",
                size = { width = 50 },
                filter = get_trouble_filter("lsp_implementations", "right"),
            },
            {
                ft = "trouble",
                title = "LSP References",
                size = { width = 50 },
                filter = get_trouble_filter("lsp_references", "right"),
            },
            {
                ft = "trouble",
                title = "LSP Type Definitions",
                size = { width = 50 },
                filter = get_trouble_filter("lsp_type_definitions", "right"),
            },
            {
                ft = "trouble",
                title = "Symbols",
                size = { width = 50 },
                filter = get_trouble_filter("symbols", "right"),
            },
            {
                ft = "gitrebase",
                size = { width = 80 },
                filter = only_buffer,
            },
            {
                ft = "gitcommit",
                size = { width = 80 },
                filter = only_buffer,
            },
            {
                ft = "git",
                size = { width = 87 },
            },
            {
                ft = "dapui_breakpoints",
                size = { width = 60, height = 30 },
            },
            {
                ft = "dapui_stacks",
                size = { hegiht = 30 },
            },
            {
                ft = "dapui_watches",
                size = { height = 10 },
            },
            {
                ft = "dapui_console",
            },
        },
        right = {
            {
                ft = "fugitive",
                open = "G",
                size = { width = 60 },
            },
            {
                ft = "help",
                size = { width = 100 },
                -- only show help buffers
                filter = function(buf)
                    return vim.bo[buf].buftype == "help"
                end,
            },
            {
                ft = "markdown",
                size = { width = 100 },
                -- only show help buffers
                filter = function(buf)
                    return vim.bo[buf].buftype == "help"
                end,
            },
            {
                ft = "text",
                size = { width = 100 },
                -- only show help buffers
                filter = function(buf)
                    return vim.bo[buf].buftype == "help"
                end,
            },
            {
                ft = "spectre_panel",
                size = { width = 100, height = 50 },
            },
            {
                ft = "",
                size = { width = 100 },
                -- exclude floating windows
                filter = function(
                    buf,
                    _ --[[win]]
                )
                    return vim.bo[buf].buftype == "terminal"
                end,
            },
            {
                ft = "toggleterm",
                size = { width = 100 },
                -- exclude floating windows
                filter = function(
                    _, --[[buf]]
                    win
                )
                    return vim.api.nvim_win_get_config(win).relative == ""
                end,
            },
        },
        bottom = {
            {
                ft = "trouble",
                title = "Diagnostics",
                size = { height = 10 },
                filter = get_trouble_filter("diagnostics", "bottom"),
            },
            {
                ft = "trouble",
                title = "Quickfix list",
                size = { height = 10 },
                filter = get_trouble_filter("qflist", "bottom"),
            },
            {
                ft = "trouble",
                title = "Location List",
                size = { height = 10 },
                filter = get_trouble_filter("loclist", "bottom"),
            },
            {
                ft = "trouble",
                title = "Quickfix",
                size = { height = 10 },
                filter = get_trouble_filter("quickfix", "bottom"),
            },
            {
                ft = "trouble",
                title = "Telescope",
                size = { height = 10 },
                filter = get_trouble_filter("telescope", "bottom"),
            },
            {
                ft = "qf",
                title = "Quickfix",
                size = { height = 10 },
            },
            {
                ft = "dapui_scopes",
                size = { height = 30 },
            },
            {
                ft = "dap_console",
                size = { widrh = 60 },
            },
            {
                ft = "dap-repl",
                size = { widrh = 60 },
            },
        },
        icons = {
            closed = icons.closed .. " ",
            open = icons.open .. " ",
        },
    },
}
