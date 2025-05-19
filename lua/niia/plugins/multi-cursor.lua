return {
    {
        "zaucy/mcos.nvim",
        dependencies = {
            "jake-stewart/multicursor.nvim",
        },
        keys = {
            {
                "gms",
                desc = "Multicursor visual",
                expr = true,
                mode = { "n", "v" },
            },
            {
                "gmss",
                function()
                    require("mcos").bufkeymapfunc()
                end,
                desc = "Multicursor entire buffer",
                mode = "n",
            },
        },
        config = function(_, _)
            local mcos = require("mcos")
            mcos.setup({})

            -- mcos doesn't setup any keymaps
            -- here are some recommended ones
            vim.keymap.set({ "n", "v" }, "gms", mcos.opkeymapfunc, { expr = true })
        end,
    },
    {
        "jake-stewart/multicursor.nvim",
        keys = {
            -- Add or skip cursor above/below the main cursor.
            {
                "<s-up>",
                function()
                    require("multicursor-nvim").lineAddCursor(-1)
                end,
                desc = "Add cursor above",
                mode = { "n", "x" },
            },
            {
                "<s-down>",
                function()
                    require("multicursor-nvim").lineAddCursor(1)
                end,
                desc = "Add cursor below",
                mode = { "n", "x" },
            },
            {
                "<leader><s-up>",
                function()
                    require("multicursor-nvim").lineSkipCursor(-1)
                end,
                desc = "Skip cursor above",
                mode = { "n", "x" },
            },
            {
                "<leader><s-down>",
                function()
                    require("multicursor-nvim").lineSkipCursor(1)
                end,
                desc = "Skip cursor below",
                mode = { "n", "x" },
            },

            -- Add or skip adding a new cursor by matching word/selection
            {
                "<localleader>n",
                function()
                    require("multicursor-nvim").matchAddCursor(1)
                end,
                desc = "Add cursor to next match",
                mode = { "n", "x" },
            },
            {
                "<localleader>s",
                function()
                    require("multicursor-nvim").matchSkipCursor(1)
                end,
                desc = "Add cursor to previous match",
                mode = { "n", "x" },
            },
            {
                "<localleader>N",
                function()
                    require("multicursor-nvim").matchAddCursor(-1)
                end,
                desc = "Skip next match",
                mode = { "n", "x" },
            },
            {
                "<localleader>S",
                function()
                    require("multicursor-nvim").matchSkipCursor(-1)
                end,
                desc = "Skip previous match",
                mode = { "n", "x" },
            },

            -- Add and remove cursors with control + left click.
            {
                "<c-leftmouse>",
                function()
                    require("multicursor-nvim").handleMouse()
                end,
                desc = "Multicursor mouse click",
                mode = "n",
            },
            {
                "<c-leftdrag>",
                function()
                    require("multicursor-nvim").handleMouseDrag()
                end,
                desc = "Multicursor mouse drag",
                mode = "n",
            },
            {
                "<c-leftrelease>",
                function()
                    require("multicursor-nvim").handleMouseRelease()
                end,
                desc = "Multicursor mouse release",
                mode = "n",
            },

            -- Disable and enable cursors.
            {
                "<c-q>",
                function()
                    require("multicursor-nvim").toggleCursor()
                end,
                desc = "Toggle cursor",
                mode = { "n", "x" },
            },
        },
        opts = {},
        config = function(_, _)
            local mc = require("multicursor-nvim")
            mc.setup()

            -- Mappings defined in a keymap layer only apply when there are
            -- multiple cursors. This lets you have overlapping mappings.
            mc.addKeymapLayer(function(layerSet)
                -- Select a different cursor as the main one.
                layerSet({ "n", "x" }, "<left>", mc.prevCursor)
                layerSet({ "n", "x" }, "<right>", mc.nextCursor)

                -- Delete the main cursor.
                layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

                -- Enable and clear cursors using escape.
                layerSet("n", "<esc>", function()
                    if not mc.cursorsEnabled() then
                        mc.enableCursors()
                    else
                        mc.clearCursors()
                    end
                end)
            end)
        end,
    },
}
