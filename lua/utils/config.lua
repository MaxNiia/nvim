local file_path = vim.fn.expand("~/.local/share/nvim/niia.txt")

local function save()
    local f = assert(io.open(file_path, "w"))
    local function bool_to_int(b)
        if b then
            return 1
        end
        return 0
    end
    f:write("neotree:", bool_to_int(_G.neotree))
    f:write("\n")
    f:write("mini.files:", bool_to_int(_G.mini_files))
    f:close()
end

local function load()
    local function int_to_bool(i)
        if i == 1 then
            return true
        else
            return false
        end
    end

    local f = io.open(file_path, "r")
    if f == nil then
        _G.mini_files = true
        _G.neotree = false
        save()
        return
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
            if name == "mini.files" then
                _G.mini_files = value
            elseif name == "neotree" then
                _G.neotree = value
            end
        end
    end
    f:close()
end

return {
    save = save,
    load = load,
}
