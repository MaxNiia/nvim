local global_snippets = {
    { trigger = "shebang", body = "#!/bin sh" },
}
local snippets_by_filetype = {
    lua = {},
    cmake = {},
    c = {},
    cpp = require("snippets.cpp"),
    python = {
        { trigger = "shebang", body = "#!/usr/bin/env python" },
    },
}

table.insert(
    snippets_by_filetype.cmake,
    { trigger = "copyright", body = CONFIGS.copyright_text.value("#") }
)
table.insert(
    snippets_by_filetype.c,
    { trigger = "copyright", body = CONFIGS.copyright_text.value("//") }
)
table.insert(
    snippets_by_filetype.cpp,
    { trigger = "copyright", body = CONFIGS.copyright_text.value("//") }
)

local function get_buf_snips()
    local ft = vim.bo.filetype
    local snips = vim.list_slice(global_snippets)

    if ft and snippets_by_filetype[ft] then
        vim.list_extend(snips, snippets_by_filetype[ft])
    end

    return snips
end

-- cmp source for snippets to show up in completion menu
local M = {}

function M.register_cmp_source()
    local cmp_source = {}
    local cache = {}
    function cmp_source.complete(_, _, callback)
        local bufnr = vim.api.nvim_get_current_buf()
        if not cache[bufnr] then
            local completion_items = vim.tbl_map(function(s)
                ---@type lsp.CompletionItem
                local item = {
                    word = s.trigger,
                    label = s.trigger,
                    kind = vim.lsp.protocol.CompletionItemKind.Snippet,
                    insertText = s.body,
                    insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
                }
                return item
            end, get_buf_snips())

            cache[bufnr] = completion_items
        end

        callback(cache[bufnr])
    end

    require("cmp").register_source("snp", cmp_source)
end

return M
