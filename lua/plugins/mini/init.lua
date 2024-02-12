return {
    {
        "echasnovski/mini.ai",
        version = false,
        event = "BufEnter",
        config = true,
    },
    {
        "echasnovski/mini.bracketed",
        version = false,
        event = "BufEnter",
        config = true,
    },
    {
        "echasnovski/mini.comment",
        version = false,
        event = "BufEnter",
        opts = {
            options = {
                custom_commentstring = nil,
                ignore_blank_line = true,
            },
        },
        config = true,
    },
    {
        "echasnovski/mini.surround",
        version = false,
        event = "BufEnter",
        opts = {
            custom_surroundings = {
                ["("] = { input = { "%b()", "^.().*().$" }, output = { left = "(", right = ")" } },
                ["["] = { input = { "%b[]", "^.().*().$" }, output = { left = "[", right = "]" } },
                ["{"] = { input = { "%b{}", "^.().*().$" }, output = { left = "{", right = "}" } },
                ["<"] = { input = { "%b<>", "^.().*().$" }, output = { left = "<", right = ">" } },
            },
        },
        config = true,
    },
    {
        "echasnovski/mini.cursorword",
        version = false,
        event = "BufEnter",
        config = true,
    },
    {
        "echasnovski/mini.pairs",
        version = false,
        event = "BufEnter",
        config = true,
    },
    require("plugins.mini.files"),
}
