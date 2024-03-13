return {
    {
        "jay-babu/mason-nvim-dap.nvim",
        enabled = not vim.g.vscode,
        dependencies = {
            "williamboman/mason.nvim",
        },
        lazy = true,
        opts = {
            ensure_installed = {
                "python",
                "cppdbg",
            },
            automatic_setup = true,
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end,
                cpp = function(source_name) end,
                python = function(config)
                    config.adapters.python = {
                        type = "executable",
                        command = os.getenv("HOME") .. "/venvs/Debug/bin/python",
                        args = {
                            "-m",
                            "debugpy.adapter",
                        },
                    }
                    config.configurations.python = {
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
                    require("mason-nvim-dap").default_setup(config)
                end,
            },
        },
        config = function(_, opts)
            require("mason-nvim-dap").setup(opts)
        end,
    },
}
