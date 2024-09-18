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
        "-j=" .. tostring(OPTIONS.clangd_num_cores.value),
        "--background-index=true",
        "--clang-tidy",
        "--completion-style=detailed",
        "--malloc-trim",
        "--all-scopes-completion=true",
        "--query-driver=" .. CONFIGS.clangd_query_driver.value,
        "--header-insertion=iwyu",
    },
}
