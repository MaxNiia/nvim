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
        "-j=4",
        "--background-index=true",
        "--clang-tidy",
        "--completion-style=detailed",
        vim.fn.has("macunix") and "--malloc-trim" or "",
        "--all-scopes-completion=true",
        "--query-driver=" .. vim.g.clangd_query_driver,
        "--header-insertion=iwyu",
    },
}
