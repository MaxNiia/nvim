local max_length = 0
for _, config in pairs(OPTIONS) do
    local length = config.description:len()
    max_length = length > max_length and length or max_length
end

local get_offset = function(name)
    return max_length - name:len() + 3
end

local hint_builder = function(name, key, description)
    local spacing = string.rep(" ", get_offset(description))
    local key_spacing = string.rep(" ", 3 - key:len())
    return "  _"
        .. key
        .. "_"
        .. key_spacing
        .. "│"
        .. " "
        .. description
        .. spacing
        .. "%{"
        .. name
        .. "}"
        .. "  "
end

local hint_builders = {
    boolean = hint_builder,
    string = hint_builder,
    number = hint_builder,
    table = hint_builder,
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
    require("options.filehandler").save()
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
            if type(OPTIONS[name].prompt) == "table" then
                vim.ui.select(
                    OPTIONS[name].prompt,
                    { prompt = "Choose an option" },
                    function(selected)
                        if selected ~= nil then
                            OPTIONS[name].value = selected
                            on_set(name)
                        end
                    end
                )
            elseif type(OPTIONS[name].prompt) == "string" then
                vim.ui.input({ default = OPTIONS[name].value, prompt = prompt }, function(input)
                    if input ~= nil then
                        OPTIONS[name].value = input
                        on_set(name)
                    end
                end)
            end
        end)
    end,

    number = function(name, key, prompt)
        return head_builder(name, key, true, function()
            vim.ui.input(
                { default = tostring(OPTIONS[name].value), prompt = prompt },
                function(input)
                    if input ~= nil then
                        OPTIONS[name].value = tonumber(input) or 0
                        on_set(name)
                    end
                end
            )
        end)
    end,

    table = function(name, key, _)
        return head_builder(name, key, true, function()
            local choices = {}
            for option, _ in pairs(OPTIONS[name].prompt) do
                table.insert(choices, option)
            end

            vim.ui.select(choices, {
                prompt = "Choose an option to configure:",
                format_item = function(item)
                    return "> " .. item
                end,
            }, function(choice)
                local prompt_choice = OPTIONS[name].prompt[choice]
                if choice == "add" then
                    for prompt_name, options in pairs(prompt_choice) do
                        local config_name = ""
                        vim.ui.input(
                            { default = tostring(prompt_name), prompt = "New config name" },
                            function(input)
                                if input ~= nil then
                                    config_name = input
                                    OPTIONS[name].value[input] = {}
                                    on_set(name)
                                end
                            end
                        )

                        for _, option in pairs(options) do
                            vim.ui.input(
                                { default = tostring(OPTIONS[name].value[option]), prompt = option },
                                function(input)
                                    if input ~= nil then
                                        OPTIONS[name].value[config_name][option] = input
                                        on_set(name)
                                    end
                                end
                            )
                        end
                    end
                elseif choice == "remove" then
                    local selections = {}
                    for config_name, _ in pairs(OPTIONS[name].value) do
                        table.insert(selections, config_name)
                    end

                    vim.ui.select(selections, {
                        prompt = "Choose an option to remove:",
                        format_item = function(item)
                            return "> " .. item
                        end,
                    }, function(remove)
                        if remove == nil then
                            return
                        end

                        OPTIONS[name].value[remove] = nil
                        on_set(name)
                    end)
                else
                    vim.notify("Invalid choice", vim.log.levels.ERROR)
                end
            end)
        end)
    end,
}

local value_builders = {
    boolean = function(name)
        return function()
            return OPTIONS[name].value and require("utils.icons").progress.done
                or require("utils.icons").progress.offline
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

    table = function()
        return function()
            return "{}"
        end
    end,
}

return function()
    local heads = {}
    local hint = [[
 ^
 ^^ Options
 ]]
    local values = {}
    local hints = {}

    for option, config in pairs(OPTIONS) do
        local value_type = type(config.value)
        local builder = head_builders[value_type]

        table.insert(hints, {
            number = string.byte(config.key),
            value = hint_builders[value_type](option, config.key, config.description),
        })

        table.insert(heads, builder(option, config.key, config.prompt))

        values[option] = value_builders[value_type](option)
    end
    table.sort(hints, function(a, b)
        return a.number < b.number
    end)

    for _, value in pairs(hints) do
        hint = hint .. "\n" .. value.value
    end

    table.insert(heads, { "<Esc>", nil, { exit = true } })
    hint = hint .. "\n" .. [[
 ^
 ^^ _<Esc>_
 ]]
    return {
        name = "Options",
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
        body = "<leader>C",
        heads = heads,
    }
end
