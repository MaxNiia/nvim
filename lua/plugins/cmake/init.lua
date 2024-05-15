return {
    {
        -- NOTE: This plugin does not like being lazy loaded.
        "Civitasv/cmake-tools.nvim",
        keys = {
            {
                "<leader>cp",
                require("plugins.cmake.utils").select_presets,
                desc = "Select CMakePresets",
            },
            {
                "<leader>ct",
                require("plugins.cmake.utils").select_build_target,
                desc = "Select launch target",
            },
            {
                "<leader>cl",
                require("plugins.cmake.utils").select_launch_target,
                desc = "Select launch target",
            },
            {
                "<leader>cc",
                require("plugins.cmake.utils").configure,
                desc = "Run CMake",
            },
            {
                "<leader>cb",
                require("plugins.cmake.utils").build,
                desc = "Build selected build target",
            },
            {
                "<leader>cd",
                require("plugins.cmake.utils").debug,
                desc = "Debug (start/continue)",
            },
            {
                "<leader>cs",
                require("plugins.cmake.utils").close_debug_session,
                desc = "Debug (stop)",
            },
        },
        opts = {
            cmake_soft_link_compile_commands = false,
            cmake_compile_commands_from_lsp = true,
            cmake_build_options = { "-j32" },
            cmake_executor = {
                name = "toggleterm",
                opts = {
                    close_on_exit = false,
                    direction = "horizontal",
                    auto_scroll = true,
                },
            },
            cmake_regenerate_on_save = false,
            cmake_runner = OPTIONS.toggleterm.value and require("plugins.cmake.toggleterm")
                or require("plugins.cmake.quickfix"),
            cmake_dap_configuration = {
                name = "cpp",
                type = "cppdbg",
                request = "launch",
                stopOnEntry = false,
                runInTerminal = true,
                console = "integratedTerminal",
            },
            cmake_notifications = {
                runner = { enabled = false },
                executor = { enabled = false },
                spinner = {
                    "⠋",
                    "⠙",
                    "⠹",
                    "⠸",
                    "⠼",
                    "⠴",
                    "⠦",
                    "⠧",
                    "⠇",
                    "⠏",
                },
                refresh_rate_ms = 100,
            },
        },
        config = function(_, opts)
            require("cmake-tools").setup(opts)
        end,
    },
}
