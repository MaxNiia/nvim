local function eval()
	return require("dapui").eval()
end
local function toggle()
	return require("dapui").toggle()
end
local function hover()
	return require("dap.ui.widgets").hover()
end

return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mortepau/codicons.nvim",
			"mfussenegger/nvim-dap",
		},
		keys = {
			{ "<leader>bt", toggle, desc = "Toggle UI" },
			{ "<leader>bh", hover, desc = "Hover" },
			{ "<leader>be", eval, mode = { "n", "x" }, desc = "Evaluate expression" },
		},
		config = function(_, opts)
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
