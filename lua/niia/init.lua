---@class Niia
local M = {}

---@class niia.Config
---@field cat_oled? boolean
---@field noice_popup? boolean
---@field enable_copilot? boolean
---@field nu? boolean
---@field rnu? boolean
local config = {
    cat_oled = false,
    noice_popup = false,
    enable_copilot = false,
    jump_on_enter = false,
    nu = true,
    rnu = true,
}

---@param opts niia.Config?
M.start = function(opts)
    opts = opts or {}
    config = vim.tbl_deep_extend("force", config, opts)

    vim.g.cat_oled = config.cat_oled
    vim.g.noice_popup = config.noice_popup
    vim.g.jump_on_enter = config.jump_on_enter
    vim.g.enable_copilot = config.enable_copilot
    vim.g.nu = config.nu
    vim.g.rnu = config.rnu

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
