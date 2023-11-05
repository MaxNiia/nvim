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
        "--background-index=true",
        "--clang-tidy",
        "--completion-style=detailed",
        "--all-scopes-completion=true",
        "--query-driver='/usr/bin/clang, /usr/bin/clang++'",
        "--header-insertion=iwyu",
    },
}
