require("user.default.keybindings")
require("user.default.options")
require("user.default.packages")

if vim.env.NVIM_WORK then
    require("user.max.work.init")
else
    require("user.max.default.init")
end

require("theme.catppuccin.init")
