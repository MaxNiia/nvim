---@brief
---
--- https://github.com/JohnnyMorganz/StyLua
---
--- A deterministic code formatter for Lua 5.1, 5.2, 5.3, 5.4, LuaJIT, Luau and CfxLua/FiveM Lua

---@type vim.lsp.Config
local opts = {
    cmd = { "stylua", "--lsp" },
    filetypes = { "lua" },
    root_markers = { ".stylua.toml", "stylua.toml", ".editorconfig" },
    capabilities = {},
}

opts.capabilities = vim.tbl_deep_extend("force", require("capabilities").capabilities, opts.capabilities)

return opts
