require "paq" {
	-- let Paq manage itself
	"savq/paq-nvim"; 

	-- Theme
	{
		"catppuccin/nvim", 
		as = 'catppuccin',
	};

	-- Depency
	"nvim-lua/plenary.nvim";

	-- LSP
	"neovim/nvim-lspconfig";

	-- ?
	"svermeulen/vimpeccable";
}

require("user.lspconfig")
require("user.catppuccin")
