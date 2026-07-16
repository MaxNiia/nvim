return {
    cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
    filetypes = { "gdscript" },
    root_markers = { "project.godot" },
}
