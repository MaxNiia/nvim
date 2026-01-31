local function indent_string(levels)
    local sw = vim.bo.shiftwidth
    if sw == 0 then
        sw = vim.bo.tabstop
    end

    if vim.bo.expandtab then
        return string.rep(" ", sw * levels)
    else
        return string.rep("\t", levels)
    end
end

local function paste_copyright_header()
    local header = vim.g.copyright_text
    local cs = vim.bo.commentstring
    local prefix, suffix = cs:match("^(.*)%%s(.*)$")

    local is_block = suffix ~= nil and suffix ~= ""
    local output = ""
    local indent = indent_string(1)
    local pre = prefix

    if is_block then
        pre = indent
        output = output .. prefix .. "\n"
    end

    for _, line in ipairs(header) do
        output = output .. pre .. line:gsub("%{YEAR%}", os.date("%Y")) .. "\n"
    end

    if is_block then
        output = output .. suffix .. "\n"
    end

    vim.api.nvim_paste(output, true, -1)
end

vim.keymap.set("n", "<leader>cc", paste_copyright_header, { desc = "Copyright Header" })
