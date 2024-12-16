return {
    {
        "willem-J-an/adopure.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            {
                "<leader>ALC",
                "<cmd>AdoPure load context<cr>",
                desc = "AdoPure load context",
                mode = { "n", "v" },
            },
            {
                "<leader>ALT",
                "<cmd>AdoPure load threads<cr>",
                desc = "AdoPure load threads",
                mode = { "n", "v" },
            },
            {
                "<leader>AOQ",
                "<cmd>AdoPure open quickfix<cr>",
                desc = "AdoPure open quickfix",
                mode = { "n", "v" },
            },
            {
                "<leader>AOT",
                "<cmd>AdoPure open thread_picker<cr>",
                desc = "AdoPure open thread_picker",
                mode = { "n", "v" },
            },
            {
                "<leader>AON",
                "<cmd>AdoPure open new_thread<cr>",
                desc = "AdoPure open new_thread",
                mode = { "n", "v" },
            },
            {
                "<leader>AOE",
                "<cmd>AdoPure open existing_thread<cr>",
                desc = "AdoPure open existing_thread",
                mode = { "n", "v" },
            },
            {
                "<leader>ASC",
                "<cmd>AdoPure submit comment<cr>",
                desc = "AdoPure submit comment",
                mode = { "n", "v" },
            },
            {
                "<leader>ASV",
                "<cmd>AdoPure submit vote<cr>",
                desc = "AdoPure submit vote",
                mode = { "n", "v" },
            },
            {
                "<leader>AST",
                "<cmd>AdoPure submit thread_status<cr>",
                desc = "AdoPure submit thread_status",
                mode = { "n", "v" },
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
        end,
    },
}
