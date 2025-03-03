return {

    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        keys = {
            {
                "<up>",
                function()
                    require("multicursor-nvim").lineAddCursor(-1)
                end,
                desc = "Add cursor above",
                mode = { "n", "x" },
            },
            {
                "<down>",
                function()
                    require("multicursor-nvim").lineAddCursor(1)
                end,
                desc = "Add cursor below",
                mode = { "n", "x" },
            },
            {
                "<s-up>",
                function()
                    require("multicursor-nvim").lineSkipCursor(-1)
                end,
                desc = "Skip cursor above",
                mode = { "n", "x" },
            },
            {
                "<s-down>",
                function()
                    require("multicursor-nvim").lineSkipCursor(1)
                end,
                desc = "Skip cursor below",
                mode = { "n", "x" },
            },

            -- Add or skip adding a new cursor by matching word/selection
            {
                "<m-n>",
                function()
                    require("multicursor-nvim").matchAddCursor(1)
                end,
                desc = "Add cursor to next match",
                mode = { "n", "x" },
            },
            {
                "<m-N>",
                function()
                    require("multicursor-nvim").matchSkipCursor(1)
                end,
                desc = "Skip next match",
                mode = { "n", "x" },
            },
            {
                "<m-p>",
                function()
                    require("multicursor-nvim").matchAddCursor(-1)
                end,
                desc = "Add cursor to previous match",
                mode = { "n", "x" },
            },
            {
                "<m-P>",
                function()
                    require("multicursor-nvim").matchSkipCursor(-1)
                end,
                desc = "Skip previous match",
                mode = { "n", "x" },
            },

            -- Press `mWi"ap` will create a cursor in every match of string captured by `i"` inside range `ap`.
            {
                "<leader>cw",
                function()
                    require("multicursor-nvim").operator()
                end,
                desc = "Add cursor to match in range",
                mode = "n",
            },

            -- Add all matches in the document
            {
                "<leader>cW",
                function()
                    require("multicursor-nvim").matchAllAddCursors()
                end,
                desc = "Add cursor to every match",
                mode = { "n", "x" },
            },

            -- Rotate the main cursor.
            {
                "<left>",
                function()
                    require("multicursor-nvim").nextCursor()
                end,
                desc = "Next cursor",
                mode = { "n", "x" },
            },
            {
                "<right>",
                function()
                    require("multicursor-nvim").prevCursor()
                end,
                desc = "Previous cursor",
                mode = { "n", "x" },
            },

            -- Delete the main cursor.
            {
                "<leader>cx",
                function()
                    require("multicursor-nvim").deleteCursor()
                end,
                desc = "Delete main cursor",
                mode = { "n", "x" },
            },

            -- Add and remove cursors with control + left click.
            {
                "<c-leftmouse>",
                function()
                    require("multicursor-nvim").handleMouse()
                end,
                desc = "Add and remove cursor",
                mode = "n",
            },
            {
                "<c-leftdrag>",
                function()
                    require("multicursor-nvim").handleMouseDrag()
                end,
                desc = "Add cursor",
                mode = "n",
            },
            {
                "<c-leftrelease>",
                function()
                    require("multicursor-nvim").handleMouseRelease()
                end,
                desc = "Add cursor",
                mode = "n",
            },

            -- Easy way to add and remove cursors using the main cursor.
            {
                "<leader>cq",
                function()
                    require("multicursor-nvim").toggleCursor()
                end,
                desc = "Toggle cursors",
                mode = { "n", "x" },
            },

            -- Clone every cursor and disable the originals.
            {
                "<leader>cQ",
                function()
                    require("multicursor-nvim").duplicateCursors()
                end,
                desc = "Duplicate cursors",
                mode = { "n", "x" },
            },

            {
                "<esc>",
                function()
                    local mc = require("multicursor-nvim")
                    if not mc.cursorsEnabled() then
                        mc.enableCursors()
                    elseif mc.hasCursors() then
                        mc.clearCursors()
                    else
                        -- Default <esc> handler.
                    end
                end,
                desc = "Escape",
                mode = "n",
            },

            -- bring back cursors if you accidentally clear them
            {
                "<leader>cv",
                function()
                    require("multicursor-nvim").restoreCursors()
                end,
                desc = "Bring back cursors",
                mode = "n",
            },

            -- Align cursor columns.
            {
                "<leader>ca",
                function()
                    require("multicursor-nvim").alignCursors()
                end,
                desc = "Align columns",
                mode = "n",
            },

            -- Split visual selections by regex.
            {
                "S",
                function()
                    require("multicursor-nvim").splitCursors()
                end,
                desc = "Split",
                mode = "x",
            },

            -- Append/insert for each line of visual selections.
            {
                "I",
                function()
                    require("multicursor-nvim").insertVisual()
                end,
                desc = "Insert",
                mode = "x",
            },
            {
                "A",
                function()
                    require("multicursor-nvim").appendVisual()
                end,
                desc = "Append",
                mode = "x",
            },

            -- match new cursors within visual selections by regex.
            {
                "M",
                function()
                    require("multicursor-nvim").matchCursors()
                end,
                desc = "Match",
                mode = "x",
            },

            -- Rotate visual selection contents.
            {
                "<leader>ct",
                function()
                    require("multicursor-nvim").transposeCursors(1)
                end,
                desc = "Clockwise",
                mode = "x",
            },
            {
                "<leader>cT",
                function()
                    require("multicursor-nvim").transposeCursors(-1)
                end,
                desc = "Counter clockwise",
                mode = "x",
            },

            -- Jumplist support
            {
                "<c-i>",
                function()
                    require("multicursor-nvim").jumpForward()
                end,
                desc = "Jump forwards",
                mode = { "x", "n" },
            },
            {
                "<c-o>",
                function()
                    require("multicursor-nvim").jumpBackward()
                end,
                desc = "Jump backwards",
                mode = { "x", "n" },
            },
        },
        init = function()
            local hl = vim.api.nvim_set_hl
            hl(0, "MultiCursorCursor", { link = "Cursor" })
            hl(0, "MultiCursorVisual", { link = "Visual" })
            hl(0, "MultiCursorSign", { link = "SignColumn" })
            hl(0, "MultiCursorMatchPreview", { link = "Search" })
            hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
            hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
            hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
        end,
        config = true,
    },
}
