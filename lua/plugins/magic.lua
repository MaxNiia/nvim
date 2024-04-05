local function createAICommand(method)
    return string.format(
        "<cmd>lua require('nvim-magic.flows').%s(require('nvim-magic').backends.default)<CR>",
        method
    )
end

return {
    {
        "ricardicus/nvim-magic",
        enabled = OPTIONS.chatgpt.value and not vim.g.vscode,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>Cs", createAICommand("append_completion"), mode = "v", desc = "Completion" },
            {
                "<leader>Ca",
                createAICommand("suggest_alteration"),
                mode = "v",
                desc = "Alteration",
            },
            { "<leader>Cd", createAICommand("suggest_docstring"), mode = "v", desc = "Docstring" },
            { "<leader>Cc", createAICommand("suggest_chat"), mode = { "v", "n" }, desc = "Chat" },
            {
                "<leader>Cr",
                createAICommand("suggest_chat_reset"),
                mode = { "v", "n" },
                desc = "Reset",
            },
        },
        config = function(_, _)
            local backend_url = require("configs.ai_backend")

            require("nvim-magic").setup({
                backends = {
                    default = require("nvim-magic-openai").new({
                        api_endpoint = backend_url,
                    }),
                },
                use_default_keymap = false,
            })
        end,
    },
}
