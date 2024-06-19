return function(bufnr)
    local wk = require("which-key")

    wk.register({
        t = {
            function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enable())
            end,
            "Toggle inlay hints",
        },
    }, { prefix = "<leader>L", buffer = bufnr })
end
