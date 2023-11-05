local hint = [[
  ^ ^        File Trees
  ^
  _n_ %{neotree}^^^ Neotree
  _m_ %{mini_files} mini.files
  _t_ %{toggleterm} Toggleterm
  ^
       ^^^^                _<Esc>_
]]

local function show_state(name)
    if _G[name] then
        return "[X]"
    else
        return "[ ]"
    end
end

return {
    name = "File Trees",
    hint = hint,
    config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            position = "middle",
            funcs = {
                neotree = function()
                    return show_state("neotree")
                end,
                mini_files = function()
                    return show_state("mini_files")
                end,
                toggleterm = function()
                    return show_state("toggleterm")
                end,
            },
        },
    },
    mode = { "n", "x" },
    body = "<leader>F",
    heads = {
        {
            "n",
            function()
                _G.neotree = not _G.neotree
                require("utils.config").save_config()
            end,
            { desc = "Neotree" },
        },
        {
            "m",
            function()
                _G.mini_files = not _G.mini_files
                require("utils.config").save_config()
            end,
            { desc = "mini.files" },
        },
        {
            "t",
            function()
                _G.toggleterm = not _G.toggleterm
                require("utils.config").save_config()
            end,
            { desc = "toggleterm" },
        },
        { "<Esc>", nil, { exit = true } },
    },
}
