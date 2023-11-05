M = {}
local file_path = vim.fn.stdpath("cache") .. "/niia.txt"

local options = {
    { name = "mini_files", default = true },
    { name = "neotree", default = false },
    { name = "toggleterm", default = true },
}

local separator = ":"

local function bool_to_int(b)
    return b and 1 or 0
end

local function int_to_bool(i)
    return i ~= 0
end

M.save_config = function()
    local f = assert(io.open(file_path, "w"))
    for _, option in pairs(options) do
        f:write(option.name, separator, bool_to_int(_G[option.name]), "\n")
    end

    f:close()
end

M.set_default_config = function()
    for _, option in pairs(options) do
        _G[option.name] = option.default
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
        M.set_default_config()
        M.save_config()
    end
end

local function parse_config_line(line)
    local config = { name = "", value = false }
    -- TODO: Make this more robust. Currently can only handle 'name:int\n' lines and will assume
    -- they are always a bool.
    for str in string.gmatch(line, "([^" .. separator .. "]+)") do
        if config.name == "" then
            config.name = str
        else
            config.value = int_to_bool(tonumber(str))
        end
    end

    return config
end

M.load_config = function()
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

return M
