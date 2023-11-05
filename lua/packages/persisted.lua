require("persisted").setup
{
    use_git_branch = true,
    telescope = {
        before_source = function()
            -- Close all open buffers
            -- Thanks to https://github.com/avently
            vim.api.nvim_input("<ESC>:%bd<CR>")
        end,
        after_source = function(session)
            print("Loaded session " .. session.name)
        end,
    },
}

require("telescope").load_extension("persisted")

local wk = require("which-key")
wk.register({
    s = {
        name = "Sessions",
        s = {
            "<cmd>SessionLoad<cr>",
            "Restore directory session",
        },
        l = {
            "<cmd>SessionLoadLast<cr>",
            "Restore last session",
        },
        d = {
            "<cmd>SessionStop<cr>",
            "Don't save",
        },
    },
}, {
    prefix = "<leader>"
})
