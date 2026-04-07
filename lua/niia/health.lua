local M = {}

function M.check()
    local settings = vim.g.available_settings

    for _, setting in ipairs(settings) do
        vim.health.start(setting.name)

        vim.health.info("NOTE: " .. setting.description)
        local value = vim.inspect(vim.g[setting.name])
        vim.health.ok("Value set: " .. value)
    end
end

return M
