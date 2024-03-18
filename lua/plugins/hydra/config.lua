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
  _l_ %{lsp_lines}^^^ LSP lines
  _P_ Prompt = %{prompt_end}
  ^
  ^^^^                _<Esc>_
]]

local function show_state_builder(name)
    return function()
        return _G[name] and "[X]" or "[ ]"
    end
end

local function show_string_builder(name)
    return function()
        return _G[name]
    end
end

local function head_builder(name, key, func)
    return {
        key,
        function()
            func()
            require("utils.config").save_config()
        end,
        { desc = name },
    }
end

local function head_string_builder(name, key, input_string)
    return head_builder(name, key, function()
        vim.ui.input({ default = _G[name], prompt = input_string }, function(input)
            if input ~= nil then
                _G[name] = input
            end
        end)
    end)
end

local function head_toggle_builder(name, key)
    return head_builder(name, key, function()
        _G[name] = not _G[name]
    end)
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
                lsp_lines = show_state_builder("lsp_lines"),
                prompt_end = show_string_builder("prompt_end"),
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
        head_toggle_builder("lsp_lines", "l"),
        head_string_builder("prompt_end", "P", "Enter your terminal prompt: "),
        { "<Esc>", nil, { exit = true } },
    },
}
