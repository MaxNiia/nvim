return function(bufnr)
    local wk = require("which-key")
    wk.register({
        g = {
            name = "Go to",
            D = {
                vim.lsp.buf.declaration,
                "Go to declaration",
            },
            d = {
                vim.lsp.buf.definition,
                "Go to definition",
            },
            i = {
                vim.lsp.buf.implementation,
                "Go to implementation",
            },
            r = {
                require("telescope.builtin").lsp_references,
                "Go to references",
            },
        },
        -- K = {
        -- 	vim.lsp.buf.hover,
        -- 	"Hover",
        -- },
        K = {
            function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    require("pretty_hover").hover()
                end
            end,
            "Hover",
        },
        ["<c-q>"] = {
            function()
                require("pretty_hover").close()
            end,
            "Close Hover",
        },
        ["<c-s>"] = {
            vim.lsp.buf.signature_help,
            "Signature",
        },
        ["<leader>"] = {
            d = {
                function()
                    vim.lsp.buf.format({
                        async = true,
                    })
                end,
                "Format",
            },
            a = {
                vim.lsp.buf.code_action,
                "Apply fix",
            },
            r = {
                name = "Refactor",
                n = {
                    vim.lsp.buf.rename,
                    "Rename",
                },
            },
            w = {
                name = "LSP",
                a = {
                    vim.lsp.buf.add_workspace_folder,
                    "Add workspace folder",
                },
                r = {
                    vim.lsp.buf.remove_workspace_folder,
                    "Remove workspace folder",
                },
                l = {
                    function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end,
                    "List workspace folder",
                },
            },
        },
    }, { buffer = bufnr })
end
