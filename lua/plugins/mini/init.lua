return {
    {
        "echasnovski/mini.ai",
        version = false,
        event = "BufEnter",
    },
    {
        "echasnovski/mini.bracketed",
        version = false,
        event = "BufEnter",
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
    },
    {
        "echasnovski/mini.surround",
        version = false,
        event = "BufEnter",
        opts = {
             custom_surroundings = {
                ['('] = { input = { '%b()', '^.().*().$' }, output = { left = '(', right = ')' } },
                ['['] = { input = { '%b[]', '^.().*().$' }, output = { left = '[', right = ']' } },
                ['{'] = { input = { '%b{}', '^.().*().$' }, output = { left = '{', right = '}' } },
                ['<'] = { input = { '%b<>', '^.().*().$' }, output = { left = '<', right = '>' } },
              },
        }
    },
    {
        "echasnovski/mini.cursorword",
        version = false,
        event = "BufEnter",
    },
    {
        "echasnovski/mini.pairs",
        version = false,
        event = "BufEnter",
    },
    require("plugins.mini.files")
}
