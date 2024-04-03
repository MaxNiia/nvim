local file_path = vim.fn.stdpath("cache") .. "/clangd.txt"
local getQueryDriver = function()
    local default = "/usr/bin/clang, /usr/bin/clang++"
    if _G.IS_WINDOWS and not _G.IS_WSL then
        default = "gcc, g++"
    end
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

local number_of_cores = 4
if not _G.IS_WINDOWS or _G.IS_WSL then
    number_of_cores = math.floor(tonumber(vim.fn.system("nproc")) * 0.5)
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
        "-j=" .. tostring(number_of_cores),
        "--background-index=true",
        "--clang-tidy",
        "--completion-style=detailed",
        "--malloc-trim",
        "--all-scopes-completion=true",
        "--query-driver=" .. getQueryDriver(),
        "--header-insertion=iwyu",
    },
}
