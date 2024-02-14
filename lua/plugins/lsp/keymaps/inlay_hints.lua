return function(bufnr)
    local wk = require("which-key")

    wk.register({
        t = {
            function()
                vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
            end,
            "Toggle inlay hints",
        },
    }, { prefix = "<leader>w", buffer = bufnr })
end
