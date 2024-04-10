local M = { init = false }

local status = ""
local copilot_icon = require("utils.icons").kinds.Copilot
local offline_icon = require("utils.icons").progress.offline
local done_icon = require("utils.icons").progress.done
local pending_icon = require("utils.icons").progress.pending
local setup = function()
    local api = require("copilot.api")
    api.register_status_notification_handler(function(data)
        -- customize your message however you want
        if data.status == "Normal" then
            status = done_icon
        elseif data.status == "InProgress" then
            status = pending_icon
        else
            status = offline_icon
        end
        status = copilot_icon .. " " .. status
    end)
end

M.get_status = function()
    if not M.init then
        setup()
        M.init = true
    end
    return status
end

return M
