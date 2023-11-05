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

	-- Telescope
	"nvim-telescope/telescope.nvim";

	-- FZF-native
	{
		"nvim-telescop/telescop-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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

	-- Theme
	{
		"catppuccin/nvim", 
		as = "catppuccin",
	};

	-- Bufferline always after catppuccin
	"akinsho/bufferline.nvim";
}

return packageList

