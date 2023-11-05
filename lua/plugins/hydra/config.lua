local hint = [[
  ^ ^        Config
  ^
  _n_ %{neotree}^^^^ Neotree
  _m_ %{mini_files}^ mini.files
  _t_ %{toggleterm}^ Toggleterm
  _o_ %{oled}^^^^^^^ OLED Catppuccin
  ^
       ^^^^                _<Esc>_
]]

local function show_state_builder(name)
    return function()
        if _G[name] then
            return "[X]"
        else
            return "[ ]"
        end
    end
end

local function head_toggle_builder(name, key)
    return {
        key,
        function()
            _G[name] = not _G[name]
            require("utils.config").save_config()
        end,
        { desc = name },
    }
end

return {
    name = "Config",
    hint = hint,
    config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
            border = "rounded",
            position = "middle",
            funcs = {
                neotree = show_state_builder("neotree"),
                mini_files = show_state_builder("mini_files"),
                toggleterm = show_state_builder("toggleterm"),
                oled = show_state_builder("oled"),
            },
        },
    },
    mode = { "n", "x" },
    body = "<leader>F",
    heads = {
        head_toggle_builder("neotree", "n"),
        head_toggle_builder("mini_files", "m"),
        head_toggle_builder("toggleterm", "t"),
        head_toggle_builder("oled", "o"),
        { "<Esc>", nil, { exit = true } },
    },
}
