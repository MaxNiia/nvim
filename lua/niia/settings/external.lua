local year = os.date("%Y")

local setup_external = function(name, value)
    if vim.g[name] == nil then
        vim.g[name] = value
    end
end

setup_external("clangd_query_driver", "/usr/bin/clang, /usr/bin/clang++")
setup_external("copyright_text", {
    "Copyright",
    "Year: " .. year,
})
