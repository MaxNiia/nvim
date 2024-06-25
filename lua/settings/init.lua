if vim.g.neovide then
    require("settings.neovide")
elseif vim.g.vscode then
    require("settings.vscode")
end

require("settings.options")
require("settings.autocmd")
require("settings.commands")
