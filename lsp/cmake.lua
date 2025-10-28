local opts = {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    root_markers = { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake" },
    init_options = {
        buildDirectory = "build",
    },
    capabilities = {},
    docs = {
        description = [[
https://github.com/regen100/cmake-language-server

Install:
pipx install cmake-language-server
]],
    },
}

opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, require("lsp").capabilities)

return opts
