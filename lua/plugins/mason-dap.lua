local dap = require("dap")

return {
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        lazy = true,
        opts = {
            ensure_installed = {
                "python",
                "cppdbg",
            },
            automatic_setup = true,
            handlers = {
                function(source_name)
                    require("mason-nvim-dap.automatic_setup")(source_name)
                end,
                cppdbg = function(source_name)
                    require("mason-nvim-dap.automatic_setup")(source_name)
                    dap.configurations.cpp = {
                        {
                            name = "Launch file",
                            type = "cppdbg",
                            request = "launch",
                            program = function()
                                return vim.fn.input(
                                    "Path to executable: ",
                                    vim.fn.getcwd() .. "/",
                                    "file"
                                )
                            end,
                            cwd = "${workspaceFolder}",
                            stopAtEntry = true,
                            setupCommands = {
                                {
                                    text = "-enable-pretty-printing",
                                    description = "enable pretty printing",
                                    ignoreFailures = false,
                                },
                            },
                        },
                        {
                            name = "Attach to gdbserver",
                            type = "cppdbg",
                            request = "launch",
                            MIMode = "gdb",
                            miDebuggerServerAddress = function()
                                return "localhost:" .. vim.fn.input("Enter the gdb server port: ")
                            end,
                            miDebuggerPath = "/usr/bin/gdb",
                            cwd = "${workspaceFolder}",
                            program = function()
                                return vim.fn.input(
                                    "Path to executable: ",
                                    vim.fn.getcwd() .. "/",
                                    "file"
                                )
                            end,
                            setupCommands = {
                                {
                                    text = "-enable-pretty-printing",
                                    description = "enable pretty printing",
                                    ignoreFailures = false,
                                },
                            },
                        },
                    }
                    dap.configurations.c = dap.configurations.cpp
                    dap.configurations.rust = dap.configurations.cpp
                end,
                python = function(_)
                    dap.adapters.python = {
                        type = "executable",
                        command = os.getenv("HOME") .. "/venvs/Debug/bin/python",
                        args = {
                            "-m",
                            "debugpy.adapter",
                        },
                    }
                    dap.configurations.python = {
                        {
                            type = "python",
                            request = "launch",
                            name = "Launch file",
                            program = "${file}",
                            pythonPath = function()
                                local env = os.getenv("VIRTUAL_ENV")
                                if env == nil then
                                    return "/usr/bin/python3"
                                else
                                    return env .. "/bin/python"
                                end
                            end,
                        },
                    }
                end,
            },
        },
        config = function(_, opts)
            require("mason-nvim-dap").setup(opts)
        end,
    },
}
