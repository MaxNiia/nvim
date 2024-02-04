return {
    {
        "NvChad/nvim-colorizer.lua",
        lazy = true,
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
                -- "css",
                -- "javascript",
                -- "html",
                -- "lua",
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
    },
}
