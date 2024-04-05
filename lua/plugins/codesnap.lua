return {
    {
        "mistricky/codesnap.nvim",
        build = "make build_generator",
        opts = {
            has_breadcrumbs = true,
            bg_theme = "grape",
            mac_window_bar = false,
            watermark = "",
            watermark_font_family = "FiraCode Nerd Font",
            save_path = vim.fn.expand("$HOME") .. "/snap.png",
        },
    },
}
