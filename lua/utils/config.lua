M = {}

local file_path = vim.fn.expand("~/.local/share/nvim/niia.txt")

local options = {
    { name = "mini_files", default = true},
    { name = "neotree", default = false},
    { name = "toggleterm", default = true},
}

M.save_config = function()
    local f = assert(io.open(file_path, "w"))
    local function bool_to_int(b)
        if b then
            return 1
        end
        return 0
    end
    for _, option in pairs(options) do
        f:write(option.name, ":", bool_to_int(_G[option.name]), "\n")
    end

    f:close()
end

M.load_config = function()
    local function int_to_bool(i)
        if i == 1 then
            return true
        else
            return false
        end
    end

    local f = io.open(file_path, "r")
    if f == nil then
        for _, option in pairs(options) do
            _G[option.name]= option.default
        end
        M.save_config()
        f = io.open(file_path, "r")

        if f == nil then
            vim.notify("File: " .. file_path .. " can't be accessed.", vim.log.levels.ERROR)
            return
        end
    end

    local lines = f:read(2 ^ 10)
    if lines then
        for str in string.gmatch(lines, "([^\n]+)") do
            local name = ""
            local value = false
            for s in string.gmatch(str, "([^:]+)") do
                if name == "" then
                    name = s
                else
                    value = int_to_bool(tonumber(s))
                end
            end
            for _, option in pairs(options) do
                if name == option.name then
                    _G[option.name] = value
                end
            end
        end
    end
    f:close()
end

return M
