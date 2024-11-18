return function(bufnr)
    local wk = require("which-key")
    wk.add({
        {
            "gD",
            vim.lsp.buf.declaration,
            buffer = bufnr,
            desc = "Go to declaration",
        },
        {
            "gd",
            vim.lsp.buf.definition,
            buffer = bufnr,
            desc = "Go to definition",
        },
        {
            "gI",
            vim.lsp.buf.implementation,
            buffer = bufnr,
            desc = "Go to implementation",
        },
        { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
        { "gr", vim.lsp.buf.references, desc = "References", buffer = bufnr },
        {
            "gR",
            require("fzf-lua").lsp_references,
            buffer = bufnr,
            desc = "Go to references",
        },

        {
            "gK",
            function()
                return vim.lsp.buf.signature_help()
            end,
            desc = "Signature Help",
        },
        {
            "<c-k>",
            function()
                return vim.lsp.buf.signature_help()
            end,
            mode = "i",
            desc = "Signature Help",
        },
        {
            "<leader>d",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            buffer = bufnr,
            desc = "Format",
        },
        {
            "<leader>aa",
            vim.lsp.buf.code_action,
            buffer = bufnr,
            desc = "Apply fix",
        },
        {
            "<leader>rc",
            vim.lsp.codelens.run,
            desc = "Run Codelens",
            mode = { "n", "v" },
            has = "codeLens",
        },
        {
            "<leader>rC",
            vim.lsp.codelens.refresh,
            desc = "Refresh & Display Codelens",
            mode = { "n" },
            has = "codeLens",
        },
        {
            "<leader>rn",
            vim.lsp.buf.rename,
            buffer = bufnr,
            desc = "Rename",
        },
        {
            "<leader>La",
            vim.lsp.buf.add_workspace_folder,
            buffer = bufnr,
            desc = "Add workspace folder",
        },
        {
            "<leader>Lr",
            vim.lsp.buf.remove_workspace_folder,
            buffer = bufnr,
            desc = "Remove workspace folder",
        },
        {
            "<leader>Ll",
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            buffer = bufnr,
            desc = "List workspace folder",
        },
        {
            "<leader>Ld",
            function()
                vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
            end,
            buffer = bufnr,
            desc = "Toggle diagnostics for current buffer",
        },
        {
            "<leader>LD",
            function()
                vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = nil }), {
                    bufnr = nil,
                })
            end,
            buffer = bufnr,
            desc = "Toggle diagnostics buffers",
        },
    })
end
