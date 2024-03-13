return {
    {
        "iamcco/markdown-preview.nvim",
        enabled = vim.g.vscode,
        ft = "markdown",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = function()
            vim.cmd([[
                let g:mkdp_auto_start = 1
                let g:mkdp_page_title = '「${name}」'
                let g:mkdp_theme = 'dark'
                ]])
        end,
    },
}
