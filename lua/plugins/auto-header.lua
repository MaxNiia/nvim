-- File: lua/plugins/auto-header.lua
-- Project: dotfiles
-- Creation date: Thu Sep  7 20:29:42 2023
-- Author: Max Niia <muxinatorn@gmail.com>
-- -----
-- Last modified: Thu Sep  7 20:29:42 2023
-- Modified By: Max Niia
-- -----

return {
    {
        "VincentBerthier/auto-header.nvim",
        opts = {
            create = true,
            update = true,
            templates = require("configs.templates"),
            projects = require("configs.project_templates"),
        },
    },
}
