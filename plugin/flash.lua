require("flash").setup({
    search = {
        multi_window = false,
        forward = true,
        wrap = true,
        mode = "search",
        trigger = "",
        max_length = false,
    },
    label = {
        uppercase = true,
        exclude = "",
        current = true,
        after = true, ---@type boolean|number[]
        before = false, ---@type boolean|number[]
        style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
        reuse = "lowercase", ---@type "lowercase" | "all"
        distance = true,
        min_pattern_length = 0,
        rainbow = {
            enabled = true,
            shade = 5,
        },
        format = function(opts)
            return { { opts.match.label, opts.hl_group } }
        end,
    },
    highlight = {
        backdrop = false,
        matches = false,
        priority = 5000,
        groups = {
            match = "FlashMatch",
            current = "FlashCurrent",
            backdrop = "FlashBackdrop",
            label = "FlashLabel",
        },
    },
    action = nil,
    pattern = "",
    continue = false,
    config = nil,
    modes = {
        search = {
            enabled = false,
            highlight = { backdrop = false },
            jump = { history = true, register = true, nohlsearch = true },
            search = {
                incremental = true,
            },
        },
        char = {
            enabled = true,
            config = function(opts)
                opts.autohide = true
                opts.jump_labels = false
            end,
            autohide = false,
            jump_labels = false,
            multi_line = true,
            label = { exclude = "hjkliardc" },
            keys = { "f", "F", "t", "T", ";", "," },
            char_actions = function(motion)
                return {
                    [";"] = "next",
                    [","] = "prev",
                    [motion:lower()] = "next",
                    [motion:upper()] = "prev",
                }
            end,
            search = {
                wrap = false,
                incremental = false,
            },
            highlight = { backdrop = false },
            jump = { register = false },
        },
        treesitter = {
            labels = "abcdefghijklmnopqrstuvwxyz",
            jump = { pos = "range" },
            search = { incremental = false },
            label = { before = false, after = false, style = "inline" },
            highlight = {
                backdrop = false,
                matches = false,
            },
        },
        treesitter_search = {
            jump = { pos = "range" },
            search = { multi_window = false, wrap = false, incremental = false },
            remote_op = { restore = false },
            label = { before = false, after = false, style = "inline" },
        },
        remote = {
            remote_op = { restore = false, motion = false },
        },
    },
    prompt = {
        enabled = false,
        prefix = { { "⚡", "FlashPromptIcon" } },
        win_config = {
            relative = "editor",
            width = 1,
            height = 1,
            row = -1,
            col = 0,
            zindex = 1000,
        },
    },
    remote_op = {
        restore = false,
        motion = false,
    },
})
