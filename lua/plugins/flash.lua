return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<cr>",
                mode = { "n", "x", "o" },
                function()
                    local Flash = require("flash")

                    local function format(opts)
                        -- always show first and second label
                        return {
                            { opts.match.label1, "FlashMatch" },
                            { opts.match.label2, "FlashLabel" },
                        }
                    end

                    Flash.jump({
                        search = { mode = "search" },
                        label = {
                            after = false,
                            before = { 0, 0 },
                            uppercase = false,
                            format = format,
                        },
                        pattern = [[\<]],
                        action = function(match, state)
                            state:hide()
                            Flash.jump({
                                search = { max_length = 0 },
                                highlight = { matches = false },
                                label = { format = format },
                                matcher = function(win)
                                    -- limit matches to the current label
                                    return vim.tbl_filter(function(m)
                                        return m.label == match.label and m.win == win
                                    end, state.results)
                                end,
                                labeler = function(matches)
                                    for _, m in ipairs(matches) do
                                        m.label = m.label2 -- use the second label
                                    end
                                end,
                            })
                        end,
                        labeler = function(matches, state)
                            local labels = state:labels()
                            for m, match in ipairs(matches) do
                                match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                                match.label2 = labels[(m - 1) % #labels + 1]
                                match.label = match.label1
                            end
                        end,
                    })
                end,
                desc = "Jump2D",
            },
            {
                "<leader>t",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Jump",
            },
            {
                "<leader>T",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
        },
        opts = {
            search = {
                multi_window = true,
                forward = true,
                wrap = true,
                mode = "search",
                exclude = {
                    "cmp_menu",
                    "flash_prompt",
                    function(win)
                        return not vim.api.nvim_win_get_config(win).focusable
                    end,
                },
                trigger = "",
                max_length = false,
            },
            jump = {
                jumplist = true,
                pos = "start",
                history = false,
                register = false,
                nohlsearch = false,
                autojump = false,
                inclusive = nil,
                offset = nil,
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
                backdrop = true,
                matches = true,
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
                    highlight = { backdrop = true },
                    jump = { history = true, register = true, nohlsearch = true },
                    search = {
                        incremental = true,
                    },
                },
                char = {
                    enabled = true,
                    config = function(opts)
                        opts.autohide = vim.fn.mode(true):find("no") and vim.v.operator == "y"
                        opts.jump_labels = opts.jump_labels and vim.v.count == 0
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
                    highlight = { backdrop = true },
                    jump = { register = false },
                },
                treesitter = {
                    labels = "abcdefghijklmnopqrstuvwxyz",
                    jump = { pos = "range" },
                    search = { incremental = false },
                    label = { before = true, after = true, style = "inline" },
                    highlight = {
                        backdrop = true,
                        matches = true,
                    },
                },
                treesitter_search = {
                    jump = { pos = "range" },
                    search = { multi_window = true, wrap = true, incremental = false },
                    remote_op = { restore = true },
                    label = { before = true, after = true, style = "inline" },
                },
                remote = {
                    remote_op = { restore = true, motion = true },
                },
            },
            prompt = {
                enabled = true,
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
        },
    },
}
