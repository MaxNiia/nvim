local opts = {
    cmd = { "glsl_analyzer" },
    filetypes = { "glsl" },
    root_markers = { ".git" },
    capabilities = {},
}

opts.capabilities = vim.tbl_deep_extend("force", require("capabilities").capabilities, opts.capabilities)

return opts
