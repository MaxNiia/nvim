local icons = require("utils.icons").fold

local only_buffer = function()
    -- Return false if number of buffers is less than 2
    return #vim.fn.getbufinfo({ buflisted = 1 }) > 1
end

return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    enabled = not vim.g.vscode,
    opts = {
        animate = {
            enabled = true,
            cps = 600,
        },
        left = {
            -- Neo-tree filesystem always takes half the screen height
            {
                title = "Neo-Tree",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "filesystem"
                end,
                pinned = OPTIONS.neotree.value,
                size = { height = 0.5 },
            },
            {
                title = "Neo-Tree Git",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "git_status"
                end,
                pinned = OPTIONS.neotree.value,
                open = "Neotree position=right git_status",
            },
            {
                title = "Neo-Tree Buffers",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "buffers"
                end,
                pinned = OPTIONS.neotree.value,
                open = "Neotree position=top buffers",
            },
            {
                ft = "DiffviewFiles",
                size = { width = 30 },
            },
            {
                ft = "gitrebase",
                size = { width = 72 },
                filter = only_buffer,
            },
            {
                ft = "gitcommit",
                size = { width = 72 },
                filter = only_buffer,
            },
            {
                ft = "git",
                size = { width = 80 },
            },
            {
                ft = "OverseerList",
                command = "OverseerOpen",
                size = { width = 80 },
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
                size = { width = 80 },
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
                    _ --[[buf]],
                    win
                )
                    return vim.api.nvim_win_get_config(win).relative == ""
                end,
            },
        },
        bottom = {
            {
                ft = "qf",
                title = "QuickFix",
                size = { height = 10 },
            },
        },
        icons = {
            closed = icons.closed .. " ",
            open = icons.open .. " ",
        },
    },
}
