return {
    default_config = {
        cmd = { "starlark", "--lsp" },
        filetypes = { "star", "bzl", "BUILD.bazel" },
        root_dir = function(fname)
            return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
        end,
    },
    docs = {
        description = [[
https://github.com/facebookexperimental/starlark-rust/

Install:
cargo install starlark_bin
]],
    },
    capabilities = {},
}
