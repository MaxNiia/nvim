-- NOTE: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1621
return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
    },
}
