return {
    {
        url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<Leader>wT",
                function()
                    local on = require("lsp_lines").toggle()

                    vim.diagnostic.config(require("plugins.lsp.diagnostics")(on))
                end,
                mode = "n",
                desc = "Toggle lsp_lines",
            },
        },
        main = "lsp_lines",
        config = true
    },
}
