return function(bufnr)
    local wk = require("which-key")

    wk.register({
        t = {
            function()
                vim.lsp.buf.inlay_hint(bufnr, nil)
            end,
            "Toggle inlay hints",
        },
    }, { prefix = "<leader>w", buffer = bufnr })
end
