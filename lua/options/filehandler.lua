local slash = "/"
local file_path = vim.fn.stdpath("cache") .. slash .. "niia.txt"

local separator = ":"

local function bool_to_int(b)
    return b and 1 or 0
end

local function int_to_bool(i)
    return i ~= 0
end

local function save()
    local f = assert(io.open(file_path, "w"))

    for name, option in pairs(OPTIONS) do
        local value = option.value
        local value_type = type(value)
        if value_type == "string" or value_type == "number" then
            f:write(name, separator, value, separator, "\n")
        elseif value_type == "boolean" then
            f:write(name, separator, bool_to_int(value), separator, "\n")
        elseif value_type == "table" then
            for option_name, v_table in pairs(value) do
                f:write(name, separator, option_name, separator)
                for index, v in pairs(v_table) do
                    f:write(index, separator, v, separator)
                end
                f:write("\n")
            end
        else
            vim.notify(
                "Option: " .. name .. ": " .. value_type .. " isn't of a supported type.",
                vim.log.levels.ERROR
            )
        end
    end

    f:close()
end

local function read_file()
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
        save()
    end
end

local function parse_option_line(line)
    local name = ""
    local index = ""
    local option_name = ""
    local table_value = nil

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
            elseif value_type == "table" then
                if option_name == "" then
                    option_name = str
                elseif index == "" then
                    index = str
                else
                    if table_value == nil then
                        table_value = {}
                    end
                    table_value[index] = str
                    index = ""
                end
            end
        end
    end

    if option_name ~= "" and table_value ~= nil then
        OPTIONS[name].value[option_name] = table_value
    end
end

local function load()
    local lines = read_file()

    if not lines then
        return
    end

    for line in string.gmatch(lines, "([^\n]+)") do
        parse_option_line(line)
    end
end

return { load = load, save = save }
