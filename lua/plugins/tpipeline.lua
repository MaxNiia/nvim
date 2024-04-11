return {
    {
        "vimpostor/vim-tpipeline",
        cond = not vim.g.neovide and not vim.g.vscode and (not _G.IS_WINDOWS or _G.IS_WSL),
        lazy = false,
    },
}
