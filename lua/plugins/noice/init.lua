return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
        },
        opts = function()
            if _G.popup then
                return require("plugins.noice.popup")
            else
                return require("plugins.noice.bottom")
            end
        end,
    },
}
