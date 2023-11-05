return {
    {
        "propet/colorscheme-persist.nvim",
        dependencies = {
		    "catppuccin/nvim",
		    "EdenEast/nightfox.nvim",
        },
        event = "BufEnter",
        opts = {
            -- Absolute path to file where colorscheme should be saved
            file_path = os.getenv("HOME") .. "/.nvim.colorscheme-persist.lua",
            -- In case there's no saved colorscheme yet
            fallback = "default",-- "catppuccin-mocha",
            -- List of ugly colorschemes to avoid in the selection window
            disable = {
                "darkblue",
                "default",
                "delek",
                "desert",
                "elflord",
                "evening",
                "industry",
                "koehler",
                "morning",
                "murphy",
                "pablo",
                "peachpuff",
                "ron",
                "shine",
                "slate",
                "torte",
                "zellner",
            },
            -- Options for the telescope picker
            picker_opts = {
                initial_mode = "insert",
                layout_strategy = "cursor",
                layout_config = {
                    cursor = {
                        preview_cutoff = 0,
                        height = 10,
                        width = 30,
                        preview_width = 1,
                    },
                },
                preview_cutoff = 0,
                enable_preview = true,
            },
        },
        config = function(_, opts)
            local persist_colorscheme = require("colorscheme-persist")

            -- Setup
            persist_colorscheme.setup(opts)

            -- Get stored colorscheme
            local colorscheme = persist_colorscheme.get_colorscheme()

            -- Set colorscheme
			vim.cmd.colorscheme(colorscheme)

            require("lualine")
            require("lsp-inlayhints")
        end,
    },
}
