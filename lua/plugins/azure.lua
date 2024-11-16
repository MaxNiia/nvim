return {
    {
        "willem-J-an/adopure.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            preferred_remotes = {
                vim.g.azure_remote,
            },
        },
        config = function(_, opts)
            local nio = require("nio")
            nio.run(function()
                local secret_job =
                    nio.process.run({ cmd = "echo", args = { "$AZURE_DEVOPS_EXT_PAT" } })
                if secret_job then
                    vim.tbl_extend("force", opts, {
                        pat_token = secret_job.stdout.read():sub(1, -2),
                    })
                end

                vim.g.adopure = opts
            end)

            local function set_keymap(keymap, command)
                vim.keymap.set({ "n", "v" }, keymap, function()
                    vim.cmd(command)
                end, { desc = command })
            end
            set_keymap("<leader>ALC", "AdoPure load context")
            set_keymap("<leader>ALT", "AdoPure load threads")
            set_keymap("<leader>AOQ", "AdoPure open quickfix")
            set_keymap("<leader>AOT", "AdoPure open thread_picker")
            set_keymap("<leader>AON", "AdoPure open new_thread")
            set_keymap("<leader>AOE", "AdoPure open existing_thread")
            set_keymap("<leader>ASC", "AdoPure submit comment")
            set_keymap("<leader>ASV", "AdoPure submit vote")
            set_keymap("<leader>AST", "AdoPure submit thread_status")
        end,
    },
}
