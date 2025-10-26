return {
    cmd = {"lua-language-server"},
    filetypes = {"lua"},
    root_markers = {{"stylua.toml", ".luarc.json"}, ".git"},
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                }
            }
        }
    }
}
