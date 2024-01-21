return {
    {
        "SmiteshP/nvim-navic",
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
