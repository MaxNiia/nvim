return {
    {
        "lewis6991/hover.nvim",
        opts = {
            init = function()
                -- Require providers
                require("hover.providers.lsp")
                require("hover.providers.man")
                require("hover.providers.dictionary")
                -- require('hover.providers.gh')
                -- require('hover.providers.gh_user')
                -- require('hover.providers.jira')
            end,
            preview_opts = {
                border = "single",
            },
            -- Whether the contents of a currently open hover window should be moved
            -- to a :h preview-window when pressing the hover keymap.
            preview_window = false,
            title = true,
            mouse_providers = nil,
            mouse_delay = 1000,
        },
        keys = {
            {
                "K",
                function()
                    local winid = require("ufo").peekFoldedLinesUnderCursor()
                    if not winid then
                        require("hover").hover({ bufnr = bufnr })
                    end
                end,
                desc = "Show help",
                mode = "n",
            },
            {
                "gK",
                require("hover").hover_select,
                mode = "n",
                desc = "hover.nvim (select)",
            },
            {
                "<C-p>",
                function()
                    require("hover").hover_switch("previous")
                end,
                mode = "n",
                desc = "hover.nvim (previous source)",
            },
            {
                "<C-n>",
                function()
                    require("hover").hover_switch("next")
                end,
                "n",
                desc = "hover.nvim (next source)",
            },
        },
        lazy = false,
        -- config = function(_, opts)
        --     require("hover").setup(opts)
        -- Mouse support
        -- vim.keymap.set(
        --     "n",
        --     "<MouseMove>",
        --     require("hover").hover_mouse,
        --     { desc = "hover.nvim (mouse)" }
        -- )
        -- vim.o.mousemoveevent = true
        -- end,
    },
}
