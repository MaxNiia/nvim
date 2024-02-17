return {
    {
        "NvChad/nvim-colorizer.lua",
        lazy = true,
        enabled = not _G.IS_VSCODE,
        cmd = {
            "ColorizerAttachToBuffer",
            "ColorizerDetachFromBuffer",
            "ColorizerToggle",
            "ColorizerReloadAllBuffers",
        },
        main = "colorizer",
        opts = {
            filetypes = {
                "*",
                cpp = { names = false },
                c = { names = false },
                cmp_docs = { always_update = true },
            },
            user_default_options = {
                RRGGBBAA = true,
                mode = "background",
                always_update = false,
            },
        },
        config = function(_, opts)
            local exclude_files = require("utils.exclude_files")

            for _, file in ipairs(exclude_files) do
                string.format("!%s", file)
                opts = vim.tbl_deep_extend("force", {
                    filetypes = {
                        file,
                    },
                }, opts or {})
            end

            require("colorizer").setup(opts)
        end,
    },
}
