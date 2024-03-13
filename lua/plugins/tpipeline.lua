return { {
    "vimpostor/vim-tpipeline",
    enabled = not vim.g.vscode and (not _G.IS_WINDOWS or _G.IS_WSL),
    lazy = false,
} }
