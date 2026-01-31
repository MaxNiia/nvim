local opts = {
    cmd = { "glsl_analyzer" },
    filetypes = { "glsl" },
    root_markers = { ".git" },
    capabilities = {},
}

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("capabilities").capabilities)

return opts
