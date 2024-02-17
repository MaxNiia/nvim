-- Provides the context of the scope.
return {
    {
        "haringsrob/nvim_context_vt",
        event = "BufEnter",
        enabled = not _G.IS_VSCODE,
        opts = {
            enabled = true,
            prefix = "",
        },
    },
}
