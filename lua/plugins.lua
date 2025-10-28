vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.undotree")

-- Remove when blink 2.0 is released.
vim.api.nvim_create_autocmd("PackChanged", {
    pattern = "blink.cmp",
    group = vim.api.nvim_create_augroup("blink_update", { clear = true }),
    callback = function(e)
        -- Also runs when `install`
        if e.data.kind == "update" then
            -- Recommended way to load the plugin inside `PackChanged` event
            -- vim.cmd [[packadd blink.cmp]]
            vim.cmd.packadd({ args = { e.data.spec.name }, bang = false })
            -- Build the plugin from source
            -- vim.cmd [[BlinkCmp build]]
            require("blink.cmp.fuzzy.build").build()
        end
    end,
})

vim.api.nvim_create_autocmd("PackChanged", {
    pattern = "nvim-treesitter",
    group = vim.api.nvim_create_augroup("treesitter_update", { clear = true }),
    callback = function(e)
        -- Also runs when `install`
        if e.data.kind == "update" then
            vim.cmd.packadd({ args = { e.data.spec.name }, bang = false })
            vim.cmd([[:TSUpdate]])
        end
    end,
})

local packages = {
    {
        src = "https://github.com/MagicDuck/grug-far.nvim",
        name = "grug-far",
        version = "main",
    },
    {
        src = "https://github.com/nvim-lua/plenary.nvim",
        name = "plenary",
        version = "master",
    },
    {
        src = "https://github.com/catppuccin/nvim",
        name = "catppuccin",
        version = "main",
    },
    {
        src = "https://github.com/folke/snacks.nvim",
        name = "snacks",
        version = "main",
    },
    {
        src = "https://github.com/folke/flash.nvim",
        name = "flash",
        version = "main",
    },
    {
        src = "https://github.com/folke/which-key.nvim",
        name = "which-key",
        version = "main",
    },
    {
        src = "https://github.com/saghen/blink.cmp",
        name = "blink.cmp",
        version = "main",
    },
    {
        src = "https://github.com/lewis6991/gitsigns.nvim",
        name = "gitsigns",
        version = "main",
    },
    {
        src = "https://github.com/nvim-mini/mini.nvim",
        name = "mini",
        version = "main",
    },
    {
        src = "https://github.com/mikavilpas/yazi.nvim",
        name = "yazi",
        version = "main",
    },
    {
        src = "https://github.com/tpope/vim-abolish",
        name = "vim-abolish",
        version = "master",
    },
    {
        src = "https://github.com/tpope/vim-abolish",
        name = "vim-abolish",
        version = "master",
    },
    {
        src = "https://github.com/zaucy/mcos.nvim",
        name = "mcsos",
        version = "main",
    },
    {
        src = "https://github.com/jake-stewart/multicursor.nvim",
        name = "multicursor-nvim",
        version = "main",
    },
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        name = "nvim-treesitter",
        version = "main",
    },
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
        name = "nvim-treesitter-textobjects",
        version = "main",
    },
    {
        src = "https://github.com/OXY2DEV/markview.nvim",
        name = "markview",
        version = "main",
    },
}

vim.pack.add(packages, {
    load = true,
    confirm = false,
})

local package_names = {}
for _, pkg in ipairs(packages) do
    table.insert(package_names, pkg.name)
end

local installed_packages = vim.pack.get(nil, { info = false })
local installed_package_names = {}
for _, pkg in ipairs(installed_packages) do
    table.insert(installed_package_names, pkg.spec.name)
end

local uninstall_packages = {}

for _, name in ipairs(installed_package_names) do
    local found = false
    for _, pkg in ipairs(package_names) do
        if name == pkg then
            found = true
            break
        end
    end
    if not found then
        table.insert(uninstall_packages, name)
    end
end

if next(uninstall_packages) ~= nil then
    vim.pack.del(uninstall_packages)
end
