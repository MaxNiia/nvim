local pack = require("command.pack")

vim.api.nvim_create_user_command(
    "Pack",
    function(opts)
        pack.dispatch(opts)
    end,
    {
        nargs = "*",
        complete = pack.complete,
        desc = "Pack command group (:Pack Update|Add|Remove ...)",
    }
)

-- vim.api.nvim_create_autocmd("BufLeave", {
--     pattern = "*",
--     callback = function()
--         if vim.bo.modified and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
--             vim.cmd("silent write")
--         end
--     end,
-- })
