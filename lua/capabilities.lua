local capabilities = {}
capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.general.positionEncodings = { "utf-16" }
capabilities.semanticTokensProvider = nil
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } },
}
vim.lsp.config('*', {
    capabilities = capabilities,
    root_markers = { '.git' },
})
