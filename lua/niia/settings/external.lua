local year = os.date("%Y")

local setup_external = function(name, value)
    if vim.g[name] == nil then
        vim.g[name] = value
    end
end

setup_external("azure_remote", "")
setup_external("clangd_query_driver", "/usr/bin/clang, /usr/bin/clang++")
setup_external("copyright_text", {
    "Copyright",
    "Year: " .. year,
})
setup_external("cpp_print_statements", {
    default = { 'std::cout << "%s(" __LINE__ "):" << std::endl;' },
    variable = { 'std::cout << "%s: " << %s << std::endl;' },
})
setup_external("doxygen_comment_strings", {
    start = "/**",
    middle = " * ",
    stop = " */",
})
