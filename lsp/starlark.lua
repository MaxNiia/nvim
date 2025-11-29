return {
    default_config = {
        cmd = { 'starpls' },
        root_markers = { 'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel' },
        filetypes = { "star", "bzl", "BUILD.bazel" },
        root_dir = function(fname)
            return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
        end,
    },
    docs = {
        description = [[
https://github.com/withered-magic/starpls

Install:
symlink
]],
    },
    capabilities = {},
}
