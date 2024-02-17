return {
    {
        "SmiteshP/nvim-navic",
        enabled = not _G.IS_VSCODE,
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
