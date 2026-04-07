vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.undotree")

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

local gh = function(x)
        return 'https://github.com/' .. x
end

local packages = {
    {
        src = gh("MagicDuck/grug-far.nvim"),
        name = "grug-far",
        version = "main",
    },
    {
        src = gh("nvim-lua/plenary.nvim"),
        name = "plenary",
        version = "master",
    },
    {
        src = gh("catppuccin/nvim"),
        name = "catppuccin",
        version = "main",
    },
    {
        src = gh("nvim-treesitter/nvim-treesitter"),
        name = "nvim-treesitter",
        version = "main",
    },
    {
        src = gh("nvim-treesitter/nvim-treesitter-textobjects"),
        name = "nvim-treesitter-textobjects",
        version = "main",
    },
    {
        src = gh("lewis6991/gitsigns.nvim"),
        name = "gitsigns",
        version = "main",
    },
    {
        src = gh("nvim-mini/mini.nvim"),
        name = "mini",
        version = "main",
    },
    {
        src = gh("mikavilpas/yazi.nvim"),
        name = "yazi",
        version = "main",
    },
    {
        src = gh("HiPhish/rainbow-delimiters.nvim"),
        name = "rainbow-delimiters",
        version = "master",
    },
    {
        src = gh("luukvbaal/statuscol.nvim"),
        name = "statuscol",
        version = "main",
    },
}

vim.pack.add(packages, {
    load = true,
    confirm = false,
})
