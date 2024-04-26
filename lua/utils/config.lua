local slash = _G.IS_WINDOWS and "\\" or "/"
local file_path = vim.fn.stdpath("cache") .. slash .. "niia.txt"

local separator = ":"

local function bool_to_int(b)
    return b and 1 or 0
end

local function int_to_bool(i)
    return i ~= 0
end

local function save_config()
    local f = assert(io.open(file_path, "w"))

    for name, config in pairs(OPTIONS) do
        local value = config.value
        local value_type = type(value)
        if value_type == "string" or value_type == "number" then
            f:write(name, separator, value, separator, "\n")
        elseif value_type == "boolean" then
            f:write(name, separator, bool_to_int(value), separator, "\n")
        else
            vim.notify(
                "Option: " .. name .. ": " .. value_type .. " isn't of a supported type.",
                vim.log.levels.ERROR
            )
        end
    end

    f:close()
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
        save_config()
    end
end

local function parse_config_line(line)
    local name = ""

    for str in string.gmatch(line, "([^" .. separator .. "]+)" .. separator) do
        if name == "" then
            name = str
        else
            if OPTIONS[name] == nil then
                return
            end
            local value = OPTIONS[name].value

            local value_type = type(value)
            if value_type == "string" then
                OPTIONS[name].value = str
            elseif value_type == "number" then
                OPTIONS[name].value = tonumber(str) or 0.0
            elseif value_type == "boolean" then
                OPTIONS[name].value = int_to_bool(tonumber(str))
            end
        end
    end
end

local function load_config()
    local lines = read_config_file()

    if not lines then
        return
    end

    for line in string.gmatch(lines, "([^\n]+)") do
        parse_config_line(line)
    end
end

return { load_config = load_config, save_config = save_config }
