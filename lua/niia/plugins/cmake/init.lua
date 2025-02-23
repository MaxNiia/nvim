return {
    {
        -- NOTE: This plugin does not like being lazy loaded.
        "Civitasv/cmake-tools.nvim",
        keys = {
            {
                "<leader>cp",
                require("niia.plugins.cmake.utils").select_presets,
                desc = "Select CMakePresets",
            },
            {
                "<leader>ct",
                require("niia.plugins.cmake.utils").select_build_target,
                desc = "Select build target",
            },
            {
                "<leader>cl",
                require("niia.plugins.cmake.utils").select_launch_target,
                desc = "Select launch target",
            },
            {
                "<leader>cc",
                require("niia.plugins.cmake.utils").configure,
                desc = "Run CMake",
            },
            {
                "<leader>cb",
                require("niia.plugins.cmake.utils").build,
                desc = "Build selected build target",
            },
            {
                "<leader>cd",
                require("niia.plugins.cmake.utils").debug,
                desc = "Debug (start/continue)",
            },
            {
                "<leader>cs",
                require("niia.plugins.cmake.utils").close_debug_session,
                desc = "Debug (stop)",
            },
        },
        opts = {
            cmake_soft_link_compile_commands = false,
            cmake_compile_commands_from_lsp = true,
            cmake_regenerate_on_save = false,
            cmake_build_options = { "-j32" },
            cmake_executor = { -- executor to use
                name = "quickfix", -- name of the executor
                opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
                default_opts = { -- a list of default and possible values for executors
                    quickfix = {
                        show = "always", -- "always", "only_on_error"
                        position = "belowright", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
                        size = 10,
                        encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
                        auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
                    },
                    terminal = {
                        name = "Main Terminal",
                        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
                        split_direction = "horizontal", -- "horizontal", "vertical"
                        split_size = 11,

                        -- Window handling
                        single_terminal_per_instance = true, -- Single viewport, multiple windows
                        single_terminal_per_tab = true, -- Single viewport per tab
                        keep_terminal_static_location = true, -- Static location of the viewport if avialable
                        auto_resize = true, -- Resize the terminal if it already exists

                        -- Running Tasks
                        start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
                        focus = false, -- Focus on terminal when cmake task is launched.
                        do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
                    }, -- terminal executor uses the values in cmake_terminal
                },
            },
            cmake_runner = { -- runner to use
                name = "terminal", -- name of the runner
                opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
                default_opts = { -- a list of default and possible values for runners
                    quickfix = {
                        show = "always", -- "always", "only_on_error"
                        position = "belowright", -- "bottom", "top"
                        size = 10,
                        encoding = "utf-8",
                        auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
                    },
                    toggleterm = {
                        direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
                        close_on_exit = false, -- whether close the terminal when exit
                        auto_scroll = true, -- whether auto scroll to the bottom
                        singleton = true, -- single instance, autocloses the opened one, if present
                    },
                    overseer = {
                        new_task_opts = {
                            strategy = {
                                "toggleterm",
                                direction = "horizontal",
                                autos_croll = true,
                                quit_on_exit = "success",
                            },
                        }, -- options to pass into the `overseer.new_task` command
                        on_new_task = function(task) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
                    },
                    terminal = {
                        name = "Main Terminal",
                        prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
                        split_direction = "horizontal", -- "horizontal", "vertical"
                        split_size = 11,

                        -- Window handling
                        single_terminal_per_instance = true, -- Single viewport, multiple windows
                        single_terminal_per_tab = true, -- Single viewport per tab
                        keep_terminal_static_location = true, -- Static location of the viewport if avialable
                        auto_resize = true, -- Resize the terminal if it already exists

                        -- Running Tasks
                        start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
                        focus = false, -- Focus on terminal when cmake task is launched.
                        do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
                    },
                },
            },
            cmake_notifications = {
                runner = { enabled = true },
                executor = { enabled = true },
                spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
                refresh_rate_ms = 100, -- how often to iterate icons
            },
            cmake_virtual_text_support = true, -- Show the target related to current file using virtual text (at right corner)
        },
        config = function(_, opts)
            require("cmake-tools").setup(opts)
        end,
    },
}
