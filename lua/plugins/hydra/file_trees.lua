local hint = [[
  ^ ^        File Trees
  ^
  _n_ Neotree
  _m_ mini.files
  ^
       ^^^^                _<Esc>_
]]

return {
    name = "File Trees",
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
    body = "<leader>F",
    heads = {
        {
            "n",
            function()
                _G.neotree = true
                _G.mini_files = false
                require("utils.config").save()
            end,
            { desc = "Neotree", exit = true },
        },
        {
            "m",
            function()
                _G.neotree = false
                _G.mini_files = true
                require("utils.config").save()
            end,
            { desc = "mini.files", exit = true },
        },
        { "<Esc>", nil, { exit = true } },
    },
}
