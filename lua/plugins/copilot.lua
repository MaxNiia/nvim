return {
    {
        "zbirenbaum/copilot.lua",
        cond = OPTIONS.copilot.value and not vim.g.vscode,
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                server_ops_overrides = {},
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
        dependencies = {
            "nvim-lua/plenary.nvim",
            "zbirenbaum/copilot.lua",
        },
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
                    if OPTIONS.fzf.value then
                    else
                        local actions = require("CopilotChat.actions")
                        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
                    end
                end,
                desc = "Help actions",
            },
            -- Show prompts actions with telescope
            {
                "<leader>ip",
                function()
                    if OPTIONS.fzf.value then
                    else
                        local actions = require("CopilotChat.actions")
                        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                    end
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
        },
    },
}
