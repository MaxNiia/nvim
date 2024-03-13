return {
    {
        "SmiteshP/nvim-navic",
        enabled = not vim.g.vscode,
        opts = {
            lsp = {
                preference = { "clangd", "pyright" },
            },
            highlight = true,
            click = true,
            icons = require("utils.icons").kinds,
        },
    },
}
