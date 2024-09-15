return {
    {
        "zbirenbaum/copilot.lua",
        cond = OPTIONS.copilot.value and not vim.g.vscode,
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                server_ops_overrides = {},
                filetypes = {
                    ["grug-far"] = false,
                    ["grug-far-history"] = false,
                    ["grug-far-help"] = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                },
                panel = {
                    enabled = false,
                    auto_refresh = false,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>",
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.4,
                    },
                },
                suggestion = {
                    enabled = false,
                    auto_trigger = false,
                    debounce = 75,
                    keymap = {
                        accept = "<M-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
            })
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        cond = OPTIONS.copilot.value and not vim.g.vscode,
        init = function()
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                callback = function()
                    vim.opt_local.relativenumber = true
                    vim.opt_local.number = true

                    -- C-p to print last response
                    vim.keymap.set("n", "<C-p>", function()
                        print(require("CopilotChat").response())
                    end, { buffer = true, remap = true })
                end,
            })
        end,
        keys = {
            {
                "<leader>it",
                "<cmd>CopilotChatToggle<cr>",
                desc = "Toggle",
            },
            -- Show help actions with telescope
            {
                "<leader>ih",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
                end,
                desc = "Help actions",
            },
            -- Show prompts actions with telescope
            {
                "<leader>ip",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                desc = "Prompt actions",
                mode = { "v", "n" },
            },
            {
                "<leader>iq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(
                            input,
                            { selection = require("CopilotChat.select").buffer }
                        )
                    end
                end,
                desc = "Quick chat",
                mode = { "v", "n" },
            },
        },
        opts = {
            debug = false,
            suggestion = { enabled = false },
            panel = { enabled = false },
            mappings = {
                complete = {
                    detail = "Use @<Tab> or /<Tab> for options.",
                    insert = "<Tab>",
                },
                close = {
                    normal = "q",
                    insert = "<C-c>",
                },
                reset = {
                    normal = "<C-r>",
                },
                submit_prompt = {
                    normal = "<CR>",
                    insert = "<C-m>",
                },
                accept_diff = {
                    normal = "<C-y>",
                    insert = "<C-y>",
                },
                yank_diff = {
                    normal = "gy",
                },
                show_diff = {
                    normal = "gd",
                },
                show_system_prompt = {
                    normal = "gp",
                },
                show_user_selection = {
                    normal = "gs",
                },
            },
        },
    },
}
