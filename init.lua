local year = os.date("%Y")

vim.g.projects_dir = vim.env.HOME .. "/workspace"
vim.g.work_projects_dir = "/media/max/workspace"

local setup_external = function(name, value)
    if vim.g[name] == nil then
        vim.g[name] = value
    end
end

setup_external("clangd_query_driver", "/usr/bin/clang, /usr/bin/clang++")
setup_external("copyright_text", {
    "Copyright",
    "Year: " .. year,
})

require("option")
require("plugins")
require("keybinds")
require("command")
require("lsp").init()
require("winbar")
