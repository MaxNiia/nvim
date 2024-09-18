local year = os.date("%Y")
local copyright_body = { "Copyright", "Year: " .. year }

local copyright_text = function(comment_string)
    local output_text = ""
    for _, v in ipairs(copyright_body) do
        output_text = output_text .. comment_string .. " " .. v .. "\n"
    end
    return output_text
end

return {
    configs = {
        clangd_query_driver = {
            value = "/usr/bin/clang, /usr/bin/clang++",
        },
        copyright_text = {
            value = copyright_text,
        },
        cpp_print_statements = {
            default = { 'std::cout << "%s(" __LINE__ "):" << std::endl;' },
            variable = { 'std::cout << "%s: " << %s << std::endl;' },
        },
        doxygen_comment_strings = {
            start = "/**",
            middle = " * ",
            stop = " */",
        },
        plugins = {},
    },
    load = function()
        for name, _ in pairs(OPTIONS.external.value) do
            require("external." .. name)
        end
    end,
}
