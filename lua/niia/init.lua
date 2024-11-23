---@class Niia
local M = {}

---@class niia.Config
---@field cat_oled? boolean
---@field noice_popup? boolean
local config = {
    cat_oled = false,
    noice_popup = false,
}

---@param opts niia.Config?
M.start = function(opts)
    opts = opts or {}
    config = vim.tbl_deep_extend("force", config, opts)

    vim.g.cat_oled = config.cat_oled
    vim.g.noice_popup = config.noice_popup

    if vim.fn.has("nvim-0.10.1)") ~= 1 then
        return vim.notify("nvim 0.10.1 is required", vim.log.levels.ERROR, { title = "Niia" })
    end

    require("niia.settings")

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

    require("lazy").setup("niia.plugins", {})
    vim.cmd("colorscheme catppuccin")
end

return M