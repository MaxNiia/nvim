return {
    {
        "norcalli/nvim-colorizer.lua",
        lazy = true,
        cmd = {
            "ColorizerAttachToBuffer",
            "ColorizerDetachFromBuffer",
            "ColorizerToggle",
            "ColorizerReloadAllBuffers",
        },
        main = "colorizer",
        opts = {
            "css",
            "javascript",
            "html",
            "lua",
        },
    },
}
