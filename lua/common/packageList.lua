local packageList = {
	-- Always first
	"savq/paq-nvim";

	-- Impatient
	"lewis6991/impatient.nvim";

	-- Depedency
	"nvim-lua/plenary.nvim";
	"nvim-tree/nvim-web-devicons";

	-- Which key
	"folke/which-key.nvim";

	-- Git 
	"lewis6991/gitsigns.nvim";

	-- LSP
	"neovim/nvim-lspconfig";

	-- Trouble
	"folke/trouble.nvim";

	-- Telescope
	"nvim-telescope/telescope.nvim";

	-- FZF-native
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make"
	};

	-- Aerial
	"stevearc/aerial.nvim";

	-- Tree
	"nvim-tree/nvim-tree.lua";

	-- Treesitter
	"nvim-treesitter/nvim-treesitter-context",
	"p00f/nvim-ts-rainbow",
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	};
	
	-- Beacon
	"DanilaMihailov/beacon.nvim";

	-- Blankline
	"lukas-reineke/indent-blankline.nvim";

	-- Autopairs
	"windwp/nvim-autopairs";

	-- Floaterm
	"voldikss/vim-floaterm";

	-- theme
	{
		"catppuccin/nvim", 
		as = "catppuccin",
	};

	-- Bufferline always after catppuccin
	"akinsho/bufferline.nvim";
}

return packageList

