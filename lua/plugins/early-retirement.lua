return {
	{
		"chrisgrieser/nvim-early-retierment",
		opts = {
			retirementAgeMins = 15,
			ignoredFiletypes = require("utils/exclude_files"),
			notificationOnAutoClose = true,
		},
		config = true,
		event = "VeryLazy",
	},
}
