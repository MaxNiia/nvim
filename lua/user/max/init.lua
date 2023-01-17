require("user.default.keybindings")
require("user.default.options")
require("user.default.packages")

if vim.env.NVIM_EPIROC then
    require("user.max.epiroc.init")
else
    require("user.max.default.init")
end

require("theme.catppuccin.init")
