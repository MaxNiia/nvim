local file_path = vim.fn.stdpath("cache") .. "/niia.txt"

local options = {
    mini_files = true,
    neotree = false,
    toggleterm = true,
    oled = false,
    copilot = false,
    popup = true,
    harpoon = true,
    buffer_mode = false,
    lsp_lines = true,
    prompt_end = "",
}

local separator = ":"

local function bool_to_int(b)
    return b and 1 or 0
end

local function int_to_bool(i)
    return i ~= 0
end

local function save_config()
    local f = assert(io.open(file_path, "w"))

    for name, default in pairs(options) do
        local value = _G[name]
        local value_type = type(value)
        if value_type == "string" or value_type == "number" then
            f:write(name, separator, value, "\n")
        elseif value_type == "boolean" then
            f:write(name, separator, bool_to_int(value), "\n")
        else
            vim.notify(
                "Option: " .. name .. ": " .. value_type .. " isn't of a supported type.",
                vim.log.levels.ERROR
            )
        end
    end

    f:close()
end

local function set_default_config()
    for name, default in pairs(options) do
        _G[name] = default
    end
end

local function read_config_file()
    local times = 0

    while true do
        local f = io.open(file_path, "r")

        if f ~= nil then
            local lines = f:read(2 ^ 10)
            f:close()
            return lines
        end

        -- If the file still couldn't be created tell the user.
        if times > 1 then
            vim.notify("File: " .. file_path .. " can't be accessed.", vim.log.levels.ERROR)
            return nil
        end

        times = times + 1

        -- Assume that the file couldn't be read because it doesn't exist.
        -- So set default values and try to write the file.
        set_default_config()
        save_config()
    end
end

local function parse_config_line(line)
    local config = { name = "", value = false }

    for str in string.gmatch(line, "([^" .. separator .. "]+)") do
        if config.name == "" then
            config.name = str
        else
            if options[config.name] == nil then
                vim.notify(
                    "Option: " .. config.name .. " isn't a valid option.",
                    vim.log.levels.ERROR
                )
                return { name = "" }
            end
            local default = options[config.name]

            local default_type = type(default)
            if default_type == "string" then
                config.value = str
            elseif default_type == "number" then
                config.value = tonumber(str)
            elseif default_type == "boolean" then
                config.value = int_to_bool(tonumber(str))
            else
                vim.notify(
                    "Option: " .. config.name .. " isn't of a supported type.",
                    vim.log.levels.ERROR
                )
                return { name = "" }
            end
        end
    end

    return config
end

local function load_config()
    set_default_config()

    local lines = read_config_file()

    if not lines then
        return
    end

    for line in string.gmatch(lines, "([^\n]+)") do
        local config = parse_config_line(line)
        if config.name ~= "" then
            _G[config.name] = config.value
        end
    end
end

return { load_config = load_config, save_config = save_config }
