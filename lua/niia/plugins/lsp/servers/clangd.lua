return {
    filetypes = {
        "c",
        "cpp",
        "objc",
        "objcpp",
        "cuda",
    },
    cmd = {
        "clangd",
        "-j=16",
        "--background-index=true",
        "--clang-tidy",
        "--completion-style=detailed",
        vim.fn.has("macunix") == 1 and "--malloc-trim" or nil,
        "--all-scopes-completion=true",
        "--query-driver=" .. vim.g.clangd_query_driver,
        "--header-insertion=iwyu",
    },
}
