return {
    {
        "vimpostor/vim-tpipeline",
        cond = not vim.g.vscode and (not _G.IS_WINDOWS or _G.IS_WSL),
        enabled = not vim.g.neovide,
        lazy = false,
    },
}
