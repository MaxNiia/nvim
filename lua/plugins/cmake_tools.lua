return {
    {
        "Civitasv/cmake-tools.nvim",
        event = "VeryLazy",
        ft = { "cpp", "c", "cmake" },
        opts = {
            cmake_soft_link_compile_commands = false,
            cmake_compile_commands_from_lsp = true,
            cmake_dap_configuration = {
                name = "cpp",
                type = "cppdbg",
            },
        },
    },
}
