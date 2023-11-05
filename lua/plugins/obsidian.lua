return {
    {
        "epwalsh/obsidian.nvim",
        lazy = true,
        event = { "BufReadPre " .. vim.fn.expand("~") .. "/obsidian/**.md" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            dir = "~/my-vault",
            notes_subdir = "notes",
            daily_nots = {
                folder = "notes/dailies",
                date_format = "%Y/%m/%d",
            },
            completion = {
                nvim_cmp = true,
                min_chars = 2,
                new_notes_location = "notes_subdir",
            },
            note_id_func = function(title)
                local suffix = ""
                if title ~= nil then
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.time()) .. "-" .. suffix
            end,
        },
        config = function(_, opts)
            require("obsidian").setup(opts)

            -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
            -- see also: 'follow_url_func' config option above.
            vim.keymap.set("n", "gf", function()
                if require("obsidian").util.cursor_on_markdown_link() then
                    return "<cmd>ObsidianFollowLink<CR>"
                else
                    return "gf"
                end
            end, { noremap = false, expr = true })
        end,
    },
}
