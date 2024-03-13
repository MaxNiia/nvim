return {
    {
        "chomosuke/term-edit.nvim",
        lazy = _G.toggleterm and "toggleterm" or false,
        version = "1.*",
        opts = {
           prompt_end = "╰─❯ ",
        },
    },
}
