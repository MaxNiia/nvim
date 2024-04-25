local get_offset = function(name)
    local max_length = 0
    local current_length = 0
    for option, config in pairs(OPTIONS) do
        local length
        if type(config.value) == "boolean" then
            length = 3
        else
            length = tostring(config.value):len()
        end

        if option == name then
            current_length = length
        end

        max_length = max_length < length and length or max_length
    end

    return max_length - current_length + 2
end

local hint_builder = function(name, key, description)
    local spacing = string.rep(" ", get_offset(name))
    return "  _" .. key .. "_ %{" .. name .. "}" .. spacing .. description .. "  "
end

local hint_builders = {
    boolean = hint_builder,
    string = hint_builder,
    number = hint_builder,
}

local function head_builder(name, key, do_exit, func)
    return {
        key,
        function()
            func()
        end,
        {
            exit = do_exit,
            desc = name,
            exit_before = do_exit,
        },
    }
end

local on_set = function(name)
    require("utils.config").save_config()
    if OPTIONS[name].callback then
        OPTIONS[name].callback()
    end
end

local head_builders = {
    boolean = function(name, key, _)
        return head_builder(name, key, false, function()
            OPTIONS[name].value = not OPTIONS[name].value
            on_set(name)
        end)
    end,
    string = function(name, key, prompt)
        return head_builder(name, key, true, function()
            vim.ui.input({ default = OPTIONS[name].value, prompt = prompt }, function(input)
                if input ~= nil then
                    OPTIONS[name].value = input
                end
                on_set(name)
            end)
        end)
    end,
    number = function(name, key, prompt)
        return head_builder(name, key, true, function()
            vim.ui.input(
                { default = tostring(OPTIONS[name].value), prompt = prompt },
                function(input)
                    if input ~= nil then
                        OPTIONS[name].value = tonumber(input) or 0
                    end
                    on_set(name)
                end
            )
        end)
    end,
}

local value_builders = {
    boolean = function(name)
        return function()
            return OPTIONS[name].value and "[X]" or "[ ]"
        end
    end,

    string = function(name)
        return function()
            return OPTIONS[name].value
        end
    end,

    number = function(name)
        return function()
            return tostring(OPTIONS[name].value)
        end
    end,
}

return function()
    local heads = {}
    local hint = [[
  ^^     Config
  ^
    ]]
    local values = {}

    for option, config in pairs(OPTIONS) do
        local value_type = type(config.value)

        hint = hint .. "\n" .. hint_builders[value_type](option, config.key, config.description)
        table.insert(heads, head_builders[value_type](option, config.key, config.prompt))
        values[option] = value_builders[value_type](option)
    end

    table.insert(heads, { "<Esc>", nil, { exit = true } })
    hint = hint .. "\n" .. [[
  ^
  ^^     _<Esc>_
    ]]
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
                funcs = values,
            },
        },
        mode = { "n", "x" },
        body = "<leader>F",
        heads = heads,
    }
end
