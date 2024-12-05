return {
    {
        url = "https://git.sr.ht/~p00f/godbolt.nvim/",
        cmd = {
            "Godbolt",
            "GodboltCompiler",
        },
        opts = {
            languages = {
                cpp = { compiler = "g++ 2.4", options = {} },
                c = { compiler = "cg122", options = {} },
                rust = { compiler = "r1650", options = {} },
            },
            auto_cleanup = true, -- remove highlights and autocommands on buffer close
            highlight = {
                cursor = "Visual", -- `cursor = false` to disable
                static = false,
            },
            quickfix = {
                enable = true,
                auto_open = true,
            },
            -- url = "localhost:10240",
            url = "https://godbolt.org",
        },
    },
}
