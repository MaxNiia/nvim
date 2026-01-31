local opts = {
    cmd = { "starpls" },
    filetypes = { "bzl" },
    root_markers = { "WORKSPACE", "WORKSPACE.bazel", "MODULE.bazel" },
    capabilities = {},
    docs = {
        description = [[
https://github.com/withered-magic/starpls

Install:
symlink
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", require("capabilities").capabilities, opts.capabilities)

return opts
