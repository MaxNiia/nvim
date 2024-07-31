return function(bufnr)
    local wk = require("which-key")

    wk.add({
        {
            "<leader>Lt",
            function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enable())
            end,
            buffer = bufnr,
            desc = "Toggle inlay hints",
        },
    })
end
