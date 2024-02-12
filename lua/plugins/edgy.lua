local icons = require("utils.icons").fold

return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        left = {
            -- Neo-tree filesystem always takes half the screen height
            {
                title = "Neo-Tree",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "filesystem"
                end,
                size = { height = 0.5 },
            },
            {
                title = "Neo-Tree Git",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "git_status"
                end,
                pinned = true,
                open = "Neotree position=right git_status",
            },
            {
                title = "Neo-Tree Buffers",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "buffers"
                end,
                pinned = true,
                open = "Neotree position=top buffers",
            },
        },
        -- any other neo-tree windows
        "neo-tree",
        right = {
            {
                ft = "aerial",
                pinned = true,
                open = "AerialOpen",
                size = { width = 60 },
            },
            {
                ft = "help",
                size = { height = 0.8, width = 120 },
                -- only show help buffers
                filter = function(buf)
                    return vim.bo[buf].buftype == "help"
                end,
            },
        },
        bottom = {
            "Trouble",
            { ft = "qf", title = "QuickFix" },
            { ft = "spectre_panel", size = { height = 0.4 } },
        },
        icons = {
            closed = icons.closed .. " ",
            open = icons.open .. " ",
        },
    },
}
