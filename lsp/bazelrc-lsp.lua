vim.filetype.add({
    pattern = {
        [".*.bazelrc"] = "bazelrc",
    },
})

local opts = {
    cmd = { "bazelrc-lsp", "lsp" },
    filetypes = { "bazelrc" },
    root_markers = { "WORKSPACE", "WORKSPACE.bazel", "MODULE.bazel", ".git" },
    capabilities = {},
    docs = {
        description = [[
https://github.com/salesforce-misc/bazelrc-lsp

Install:
make install-bazelrc-lsp
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("lsp").capabilities)

return opts
