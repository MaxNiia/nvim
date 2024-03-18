return {
    {
        "chomosuke/term-edit.nvim",
        lazy = _G.toggleterm,
        ft = _G.toggleterm and "toggleterm" or "",
        version = "1.*",
        opts = {
            prompt_end = "╰─❯ ",
        },
    },
}
