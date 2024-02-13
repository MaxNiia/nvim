local file_path = vim.fn.stdpath("cache") .. "/clangd.txt"
local getQueryDriver = function()
    local default = "/usr/bin/clang, /usr/bin/clang++"
    local f = io.open(file_path, "r")
    if f ~= nil then
        local lines = f:read(2 ^ 10)
        f:close()
        for line in string.gmatch(lines, "([^\n]+)") do
            return line
        end
    end
    return default
end

return {
    filetypes = {
        "c",
        "cpp",
        "objc",
        "objcpp",
        "cuda",
    },
    cmd = {
        "clangd",
        -- "-j=4",
        "--background-index=true",
        "--clang-tidy",
        "--completion-style=detailed",
        -- "--background-index-priority=low",
        "--malloc-trim",
        "--all-scopes-completion=true",
        "--query-driver=" .. getQueryDriver(),
        "--header-insertion=iwyu",
    },
}
