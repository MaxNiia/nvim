local opts = {
    root_markers = {
        {
            ".clang-format",
            "compile_commands.json",
            ".clangd",
            ".clang-tidy",
            "compile_flags.txt",
            "configure.ac", -- AutoTools
        },
        ".git",
    },
    filetypes = {
        "c",
        "cpp",
        "objc",
        "objcpp",
        "cuda",
    },
    cmd = {
        "clangd",
        "--background-index=true",
        "--clang-tidy",
        "--completion-style=detailed",
        vim.fn.has("macunix") == 1 and "--malloc-trim" or nil,
        "--all-scopes-completion=true",
        "--query-driver=" .. vim.g.clangd_query_driver,
        "--header-insertion=iwyu",
    },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
        },
    },
    docs = {
        description = [[
https://github.com/clangd/clangd

Install:
Symlink a release version.
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("lsp").capabilities)

return opts
