require("options")
require("keymap")

-- Commands
vim.api.nvim_create_user_command("ReSource", "source $MYVIMRC", {})
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
end, {})

vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.undotree")

vim.lsp.config('*', {
    root_markers = { '.git', '.hg' },
})

vim.lsp.enable({"lua_ls", "clangd", "typos_lsp",})

-- Packages
vim.pack.add(
    {
        {
            src = "https://github.com/catppuccin/nvim",
            name = "catppuccin",
            version = "main",
        },
    },
    {
        load = true,
        confirm = false,
    }
)
