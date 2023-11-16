return {
    name = "insights",
    builder = function(--[[params]])
        local file = vim.fn.expand("%:p")
        local insights_path = vim.fn.expand("~/insights/build/insights")
        return {
            cmd = { insights_path },
            args = { file },
            components = {
                { "unique" },
                "default",
                { "restart_on_save", delay = 100 },
            },
        }
    end,
    condition = {
        filetype = { "cpp", "c", "cmake" },
    },
}
