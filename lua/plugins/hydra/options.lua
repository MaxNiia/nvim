local hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} toggle spelling
  _w_ %{wrap} word wrap
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]]

return {
    name = "Options",
    hint = hint,
    config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            position = "middle",
        },
    },
    mode = { "n", "x" },
    body = "<leader>O",
    heads = {
        {
            "n",
            function()
                vim.o.number = not vim.o.number
            end,
            { desc = "number" },
        },
        {
            "r",
            function()
                if vim.o.relativenumber == true then
                    vim.o.relativenumber = false
                else
                    vim.o.number = true
                    vim.o.relativenumber = true
                end
            end,
            { desc = "relativenumber" },
        },
        {
            "S",
            function()
                require("gitsigns").toggle_signs()
            end,
            { desc = "Toggle signs" },
        },
        {
            "l",
            function()
                require("gitsigns").toggle_linehl()
            end,
            { desc = "Toggle Line HL" },
        },
        {
            "D",
            function()
                require("gitsigns").toggle_deleted()
            end,
            { desc = "Toggle deleted" },
        },
        {
            "v",
            function()
                if vim.o.virtualedit == "all" then
                    vim.o.virtualedit = "block"
                else
                    vim.o.virtualedit = "all"
                end
            end,
            { desc = "virtualedit" },
        },
        {
            "i",
            function()
                vim.o.list = not vim.o.list
            end,
            { desc = "show invisible" },
        },
        {
            "s",
            function()
                vim.o.spell = not vim.o.spell
            end,
            { exit = true, desc = "spell" },
        },
        {
            "w",
            function()
                if vim.o.wrap ~= true then
                    vim.o.wrap = true
                    -- Dealing with word wrap:
                    -- If cursor is inside very long line in the file than wraps
                    -- around several rows on the screen, then 'j' key moves you to
                    -- the next line in the file, but not to the next row on the
                    -- screen under your previous position as in other editors. These
                    -- bindings fixes this.
                    vim.keymap.set("n", "k", function()
                        return vim.v.count > 0 and "k" or "gk"
                    end, { expr = true, desc = "k or gk" })
                    vim.keymap.set("n", "j", function()
                        return vim.v.count > 0 and "j" or "gj"
                    end, { expr = true, desc = "j or gj" })
                else
                    vim.o.wrap = false
                    vim.keymap.del("n", "k")
                    vim.keymap.del("n", "j")
                end
            end,
            { desc = "wrap" },
        },
        { "<Esc>", nil, { exit = true } },
    },
}
