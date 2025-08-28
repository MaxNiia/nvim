return {
    {
        "nvim-neotest/neotest",
        cond = not vim.g.vscode,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-plenary",
            "nvim-neotest/neotest-vim-test",
            "nvim-neotest/neotest-python",
            {
                "alfaix/neotest-gtest",
                config = false,
            },
        },
        cmd = {
            "Neotest",
        },
        keys = {
            {
                "<leader>rt",
                function()
                    require("neotest").run.run({ strategy = "dap" })
                end,
                mode = "n",
                desc = "Run nearest test",
            },
            {
                "<leader>rT",
                function()
                    require("neotest").run.run(vim.fn.expand("%"), { strategy = "dap" })
                end,
                mode = "n",
                desc = "Run entire test",
            },
        },
        config = function(
            _,
            _ --[[opts]]
        )
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                    }),
                    require("neotest-plenary"),
                    require("neotest-vim-test")({
                        ignore_file_types = { "python", "vim", "lua", "c", "cpp", "rust" },
                    }),
                    require("neotest-gtest").setup({
                        debug_adapter = "cppdbg",
                    }),
                },
            })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        cond = not vim.g.vscode,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        keys = {
            {
                "<leader>du",
                function()
                    require("dapui").toggle()
                end,
                mode = "n",
                desc = "Toggle UI",
            },
            {
                "<leader>de",
                function()
                    require("dapui").eval()
                end,
                mode = "v",
                desc = "Eval",
            },
        },
        opts = {},
        config = function(_, opts)
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup(opts)
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
        name = "dapui",
    },
    {
        "mfussenegger/nvim-dap",
        cond = not vim.g.vscode,
        dependencies = {
            "jay-babu/mason-nvim-dap.nvim",
        },
        build = ":helptags ALL",
        name = "dap",
        keys = {
            {
                "<leader>dw",
                function()
                    vim.ui.input({ prompt = "Expression to watch:" }, function(expr)
                        if expr then
                            require("dap").add_watch(expr)
                        end
                    end)
                end,
                desc = "Add watch expression",
                mode = "n",
            },
            {
                "<leader>dR",
                function()
                    require("dap").restart()
                end,
                mode = "n",
                desc = "Restart debug session",
            },

            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                mode = "n",
                desc = "Toggle breakpoint",
            },
            {
                "<leader>dB",
                function()
                    vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
                        if condition then
                            require("dap").set_breakpoint(condition)
                        end
                    end)
                end,
                mode = "n",
                desc = "Set conditional breakpoint",
            },
            {
                "<leader>dl",
                function()
                    vim.ui.input({ prompt = "Log point message: " }, function(log_msg)
                        if log_msg then
                            require("dap").set_breakpoint(nil, nil, log_msg)
                        end
                    end)
                end,
                mode = "n",
                desc = "Set log point",
            },
            {
                "<leader>df",
                function()
                    vim.ui.input({ prompt = "Function name: " }, function(func_name)
                        if func_name then
                            require("dap").set_function_breakpoint(func_name)
                        end
                    end)
                end,
                mode = "n",
                desc = "Set function breakpoint",
            },
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                mode = "n",
                desc = "Toggle breakpoint",
            },
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                mode = "n",
                desc = "Continue",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_over()
                end,
                mode = "n",
                desc = "Step over",
            },
            {
                "<leader>dO",
                function()
                    require("dap").step_out()
                end,
                mode = "n",
                desc = "Step out",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                mode = "n",
                desc = "Step into",
            },
            {
                "<leader>dr",
                function()
                    require("dap").repl_open()
                end,
                mode = "n",
                desc = "Open REPL",
            },
        },
        init = function()
            -- Setup signs for nvim-dap
            vim.fn.sign_define(
                "DapBreakpoint",
                { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
            )
            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = " ", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" }
            )
            vim.fn.sign_define(
                "DapBreakpointRejected",
                { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
            )
            vim.fn.sign_define(
                "DapLogPoint",
                { text = ".>", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" }
            )
            vim.fn.sign_define("DapStopped", {
                text = "󰁕 ",
                texthl = "DiagnosticSignWarn",
                linehl = "DapStoppedLine",
                numhl = "",
            })
        end,
        config = function(
            _,
            _ --[[opts]]
        )
            local mason = require("mason-nvim-dap")
            local dap = require("dap")

            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = {
                    "--interpreter=dap",
                    "--eval-command",
                    "set print pretty on",
                },
            }
            if vim.loop.os_uname().sysname == "Windows_NT" then
                dap.adapters.cppdbg = {
                    id = "cppdbg",
                    type = "executable",
                    command = vim.fn.expand(
                        "$HOME\\.tools\\cpptools\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe"
                    ),
                    options = {
                        detached = false,
                    },
                }
            else
                dap.adapters.cppdbg = {
                    id = "cppdbg",
                    type = "executable",
                    command = vim.fn.expand("OpenDebugAD7"),
                }
            end
            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    MIMode = "gdb",
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubProgram = false,
                    stopOnEntry = false,
                    setupCommands = {
                        {
                            text = "-enable-pretty-printing",
                            description = "enable pretty printing",
                            ignoreFailures = false,
                        },
                    },
                },
                {
                    name = "Debug core dump",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    MIMode = "gdb",
                    stopOnEntry = false,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubProgram = false,
                    coreDumpPath = function()
                        return vim.fn.input("Path to core dump: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    setupCommands = {
                        {
                            text = "-enable-pretty-printing",
                            description = "enable pretty printing",
                            ignoreFailures = false,
                        },
                    },
                },
                {
                    name = "Select and attach to process",
                    type = "gdb",
                    request = "attach",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    pid = function()
                        local name = vim.fn.input("Executable name (filter): ")
                        return require("dap.utils").pick_process({ filter = name })
                    end,
                    MIMode = "gdb",
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    setupCommands = {
                        {
                            text = "-enable-pretty-printing",
                            description = "enable pretty printing",
                            ignoreFailures = false,
                        },
                    },
                },
                {
                    name = "Attach to gdbserver :1234",
                    type = "cppdbg",
                    request = "attach",
                    target = "localhost:1234",
                    MIMode = "gdb",
                    stopOnEntry = false,
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    setupCommands = {
                        {
                            text = "-enable-pretty-printing",
                            description = "enable pretty printing",
                            ignoreFailures = false,
                        },
                    },
                },
            }
            dap.configurations.cpp = dap.configurations.c
            dap.configurations.rust = dap.configurations.c
            mason.setup({
                automatic_installation = true,
                ensure_installed = {
                    "python",
                    "cppdbg",
                    "codelldb",
                },
            })
        end,
    },
}
