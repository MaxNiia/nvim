local function load_current_cmake_targets_to_dap(callback)
    local cmake_tools = require("cmake-tools")

    if cmake_tools.is_cmake_project() then
        cmake_tools.get_cmake_launch_targets(function(targets)
            local target_configs = {}
            local build_type = tostring(cmake_tools.get_build_type().value)
            local launch_target = cmake_tools.get_launch_target()
            local launch_target_config = nil

            for k, v in pairs(targets.data.targets) do
                if v == launch_target then
                    launch_target_config = {
                        name = "* " .. v .. " [" .. build_type .. "]",
                        type = "cppdbg",
                        request = "launch",
                        args = "",
                        program = targets.data.abs_paths[k],
                        cwd = "${workspaceFolder}",
                        stopAtEntry = false,
                        setupCommands = {
                            {
                                text = "-enable-pretty-printing",
                                description = "enable pretty printing",
                                ignoreFailures = false,
                            },
                        },
                    }
                end

                table.insert(target_configs, {
                    name = v .. " [" .. build_type .. "]",
                    type = "cppdbg",
                    request = "launch",
                    args = "",
                    program = targets.data.abs_paths[k],
                    cwd = "${workspaceFolder}",
                    stopAtEntry = false,
                    setupCommands = {
                        {
                            text = "-enable-pretty-printing",
                            description = "enable pretty printing",
                            ignoreFailures = false,
                        },
                    },
                })
            end

            local dap = require("dap")
            dap.configurations.cpp = {}
            vim.list_extend(dap.configurations.cpp, target_configs)
            if callback then
                callback(launch_target_config)
            end
        end)
    end
end

local configure = function()
    require("trouble").close()

    require("cmake-tools").generate({}, function() end)
end

local build = function()
    require("trouble").close()

    require("cmake-tools").quick_build({ fargs = { require("cmake-tools").get_build_target() } })
end

local debug_cmake = function()
    require("trouble").close()

    load_current_cmake_targets_to_dap(function(launch_target_config)
        vim.cmd("cclose")

        require("dap").run(launch_target_config)
    end)
end

local close_debug_session = function()
    require("dap").terminate()

    require("dapui").close()
end

local select_build_target = function()
    require("cmake-tools").select_build_target({}, {})
end

local select_launch_target = function()
    require("cmake-tools").select_launch_target({}, {})
end

local select_presets = function()
    require("trouble").close()

    require("cmake-tools").select_configure_preset(function()
        require("cmake-tools").select_build_preset()
    end)
end

return {
    {
        "Civitasv/cmake-tools.nvim",
        ft = {
            "cpp",
            "c",
            "cmake",
        },
        cond = not vim.g.vscode,
        keys = {
            {
                "<leader>cp",
                select_presets,
                desc = "Select CMakePresets",
            },
            {
                "<leader>ct",
                select_build_target,
                desc = "Select build target",
            },
            {
                "<leader>cl",
                select_launch_target,
                desc = "Select launch target",
            },
            {
                "<leader>cc",
                configure,
                desc = "Run CMake",
            },
            {
                "<leader>cb",
                build,
                desc = "Build selected build target",
            },
            {
                "<leader>cd",
                debug_cmake,
                desc = "Debug (start/continue)",
            },
            {
                "<leader>cs",
                close_debug_session,
                desc = "Debug (stop)",
            },
        },
        opts = {
            cmake_regenerate_on_save = false,
            cmake_dap_configuration = {
                name = "cpp",
                type = "cppdbg",
                request = "launch",
                stopOnEntry = false,
                runInTerminal = true,
                console = "integratedTerminal",
            },
            cmake_virtual_text_support = true,
        },
        config = true,
    },
}
