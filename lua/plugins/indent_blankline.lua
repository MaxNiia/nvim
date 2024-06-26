return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = true,
        event = { "BufEnter" },
        init = function()
            vim.opt.list = true
        end,
        opts = {
            indent = {
                char = "│",
            },
            exclude = {
                filetypes = { "help", "alpha", "dashboard", "Nvim-tree", "Trouble", "lazy" },
            },
            scope = {
                enabled = true,
                show_start = true,
                show_end = true,
                show_exact_scope = true,
                injected_languages = true,
                include = {
                    node_type = { lua = { "return_statement", "table_constructor" } },
                },
            },
        },
    },
}
