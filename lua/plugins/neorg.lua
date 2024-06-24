return {
    {
        "nvim-neorg/neorg",
        -- dependencies = { "nvim-treesitter" },
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
                ["core.integrations.nvim-cmp"] = {},

                ["core.journal"] = {
                    config = {
                        journal_folder = "journal",
                    },
                },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
                    },
                },
                ["core.concealer"] = {},
            },
        },
    },
}
