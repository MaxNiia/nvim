local mc = require("multicursor-nvim")
mc.setup()
vim.keymap.set(
    { "n", "x" },
    "<s-up>",
    function()
        require("multicursor-nvim").lineAddCursor(-1)
    end,
    { desc = "Add cursor above", }
)
vim.keymap.set(
    { "n", "x" },
    "<s-down>",
    function()
        require("multicursor-nvim").lineAddCursor(1)
    end,
    { desc = "Add cursor below", }
)
vim.keymap.set(
    { "n", "x" },
    "<leader><s-up>",
    function()
        require("multicursor-nvim").lineSkipCursor(-1)
    end,
    { desc = "Skip cursor above", }
)
vim.keymap.set(
    { "n", "x" },
    "<leader><s-down>",
    function()
        require("multicursor-nvim").lineSkipCursor(1)
    end,
    { desc = "Skip cursor below", }
)
-- Add or skip adding a new cursor by matching word/selection
vim.keymap.set(
    { "n", "x" },
    "<localleader>n",
    function()
        require("multicursor-nvim").matchAddCursor(1)
    end,
    { desc = "Add cursor to next match", }
)
vim.keymap.set(
    { "n", "x" },
    "<localleader>s",
    function()
        require("multicursor-nvim").matchSkipCursor(1)
    end,
    { desc = "Add cursor to previous match", }
)
vim.keymap.set(
    { "n", "x" },
    "<localleader>N",
    function()
        require("multicursor-nvim").matchAddCursor(-1)
    end,
    { desc = "Skip next match", }
)
vim.keymap.set(
    { "n", "x" },
    "<localleader>S",
    function()
        require("multicursor-nvim").matchSkipCursor(-1)
    end,
    { desc = "Skip previous match", }
)
-- Add and remove cursors with control + left click.
vim.keymap.set(
    "n",
    "<c-leftmouse>",
    mc.handleMouse,
    { desc = "Multicursor mouse click", }
)
vim.keymap.set(
    "n",
    "<c-leftdrag>",
    mc.handleMouseDrag,
    { desc = "Multicursor mouse drag", }
)
vim.keymap.set(
    "n",
    "<c-leftrelease>",
    mc.handleMouseRelease,
    { desc = "Multicursor mouse release", }
)
-- Disable and enable cursors.
vim.keymap.set(
    { "n", "x" },
    "<c-q>",
    mc.toggleCursor,
    { desc = "Toggle cursor", }
)

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


local mcos = require("mcos")
mcos.setup({})
vim.keymap.set(
    { "n", "v" },
    "gms",
    mcos.opkeymapfunc,
    {
        desc = "Multicursor visual",
        expr = true,
    }
)
vim.keymap.set(
    "n",
    "gmss",
    mcos.bufkeymapfunc,
    {  desc = "Multicursor entire buffer",  }
)
