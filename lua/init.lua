return {
    start = function(opts)
        vim.g.cat_oled = opts.cat_oled
        vim.g.noice_popup = opts.noice_popup

        require("settings")

        -- Bootstrap lazy.nvim
        local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        if not vim.uv.fs_stat(lazypath) then
            vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                lazypath,
            })
        end
        vim.opt.rtp:prepend(lazypath)

        require("lazy").setup("plugins", {})
        vim.cmd("colorscheme catppuccin")
    end,
}
