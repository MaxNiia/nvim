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
        "--background-index",
        "--background-index-priority=low",
        "--clang-tidy",
        "--completion-style=detailed",
        "--function-arg-placeholders=false",
        vim.fn.has("macunix") == 1 and "--malloc-trim" or nil,
        "--all-scopes-completion=true",
        "--query-driver=/usr/bin/clang, /usr/bin/clang++",
        "--header-insertion=iwyu",
        "-j=4",
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

return opts
