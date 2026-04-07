local settings = {}
---@class options.SettingConfig
---@field name string
---@field default_value string|integer|boolean|table
---@field description string

---@param config options.SettingConfig
local setting = function(config)
    if vim.g[config.name] == nil then
        vim.g[config.name] = config.default_value
    end

    table.insert(settings, config)
end

-- SCREAM case is for config wide settings (saved in shada).
-- snake case is for project wide settings (saved in session).
setting({
    name = "special_dirs",
    default_value = {
        WORKSPACE = vim.fn.expand("~/workspace/dev/"),
        NOTES = vim.fn.expand("~/Documents/notes/"),
    },
    description = "Table of string which will replace the path when in file paths, in the winbar.",
})

vim.g.available_settings = settings
