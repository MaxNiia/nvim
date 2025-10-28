vim.filetype.add({
    pattern = {
        [".*.bazelrc"] = "bazelrc",
    },
})

local opts = {
    default_config = {
        cmd = { "bazelrc-lsp", "lsp" },
        filetypes = { "bazelrc" },
        root_dir = { "WORKSPACE", "WORKSPACE.bazel", "MODULE.bazel", ".git" },
    },
    docs = {
        description = [[
https://github.com/salesforce-misc/bazelrc-lsp

Install:
Symlink a release version.
]],
    },
    capabilities = {},
}

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("lsp").capabilities)

return opts
