return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		event = "BufEnter",
		lazy = true,
		opts = {
			ensure_installed = {
				"python",
				"cppdbg",
			},
			automatic_setup = true,
		},
		config = function(_, opts)
			local dap = require("dap")
			local mason_dap = require("mason-nvim-dap")

			mason_dap.setup(opts)
			mason_dap.setup_handlers({
				function(source_name)
					require("mason-nvim-dap.automatic_setup")(source_name)
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
			})
		end,
	},
}
