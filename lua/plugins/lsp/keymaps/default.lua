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
                function()
                    if OPTIONS.fzf.value then
                        require("fzf-lua").lsp_references()
                    else
                        require("telescope.builtin").lsp_references({
                            fname_width = require("utils.sizes").fname_width,
                            include_declaration = false,
                            include_current_line = true,
                            jump_type = "never",
                        })
                    end
                end,
                "Go to references",
            },
        },
        K = {
            function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    require("hover").hover()
                end
            end,
            "Hover",
        },
        ["<c-s>"] = {
            vim.lsp.buf.signature_help,
            "Signature",
        },
        ["<leader>"] = {
            d = {
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                    -- vim.lsp.buf.format({
                    --     async = true,
                    -- })
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
            L = {
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
                d = {
                    function()
                        vim.diagnostic.enable(
                            not vim.diagnostic.is_enabled({ bufnr = 0 }),
                            { bufnr = 0 }
                        )
                    end,
                    "Toggle diagnostics for current buffer",
                },
                D = {
                    function()
                        vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = nil }), {
                            bufnr = nil,
                        })
                    end,
                    "Toggle diagnostics buffers",
                },
            },
        },
    }, { buffer = bufnr })
end
