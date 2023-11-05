require('impatient')

if vim.env.NVIM_MAX then
    require("user.max.init")
else
    require("user.default.init")
end
