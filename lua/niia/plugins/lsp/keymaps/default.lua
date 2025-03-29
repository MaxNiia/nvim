return function(bufnr)
    local wk = require("which-key")
    wk.add({
        {
            "gK",
            function()
                return vim.lsp.buf.signature_help()
            end,
            desc = "Signature Help",
        },
        {
            "K",
            function()
                vim.lsp.buf.hover()
            end,

            desc = "Show help",

            mode = "n",
        },
        {
            "grd",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            buffer = bufnr,
            desc = "Format",
        },
        {
            "<leader>rc",
            vim.lsp.codelens.run,
            desc = "Run Codelens",
            mode = { "n", "v" },
        },
        {
            "<leader>rC",
            vim.lsp.codelens.refresh,
            desc = "Refresh & Display Codelens",
            mode = { "n" },
        },
    })
end
