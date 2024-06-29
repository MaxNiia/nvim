return function(lsp_lines)
    return lsp_lines
            and {
                underline = true,
                update_in_insert = false,
                virtual_text = false,
                severity_sort = true,
                virtual_lines = true,
            }
        or {
            underline = true,
            update_in_insert = false,
            virtual_text = { spacing = 4, prefix = "●" },
            severity_sort = true,
            virtual_lines = false,
        }
end
