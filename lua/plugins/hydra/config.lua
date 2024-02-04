local hint = [[
  ^^     Config
  ^
  _n_ %{neotree}^^^^^ Neotree
  _m_ %{mini_files}^^ mini.files
  _t_ %{toggleterm}^^ Toggleterm
  _o_ %{oled}^^^^^^^^ OLED Catppuccin
  _c_ %{copilot}^^^^^ Copilot
  _p_ %{popup}^^^^^^^ Popup
  _h_ %{harpoon}^^^^^ Harpoon
  _b_ %{buffer_mode}^ Buffer Mode
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
            float_opts = {
                border = "rounded",
            },
            position = "middle",
            funcs = {
                neotree = show_state_builder("neotree"),
                mini_files = show_state_builder("mini_files"),
                toggleterm = show_state_builder("toggleterm"),
                oled = show_state_builder("oled"),
                copilot = show_state_builder("copilot"),
                popup = show_state_builder("popup"),
                harpoon = show_state_builder("harpoon"),
                buffer_mode = show_state_builder("buffer_mode"),
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
        head_toggle_builder("copilot", "c"),
        head_toggle_builder("popup", "p"),
        head_toggle_builder("harpoon", "h"),
        head_toggle_builder("buffer_mode", "b"),
        { "<Esc>", nil, { exit = true } },
    },
}
