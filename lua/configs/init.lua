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
    clangd_query_driver = {
        value = "/usr/bin/clang, /usr/bin/clang++",
    },
    copyright_text = {
        value = copyright_text,
    },
    doxygen_comment_strings = {
        start = "/**",
        middle = " * ",
        stop = "*/",
    },
    plugins = {},
}
