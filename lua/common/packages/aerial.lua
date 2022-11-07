require("aerial").setup({
	on_attach = function(bufnr)
		local wk = require("which-key")
		wk.register({
			["["] = {
				"<cmd>AerialPrev<CR>", 
				"Previous Aerial"
			},
			["]"] = {
				"<cmd>AerialNext<CR>",
				"Next Aerial"
			}
		}, 
		{
			buffer = bufnr,
		})
	end,
})

local wk = require("which-key")
wk.register(
{
	a = {
		"<cmd>AerialToggle!<CR>",
		"Toggle Aerial",
	}
}, 
{ 
	prefix = "<leader>" 
})
