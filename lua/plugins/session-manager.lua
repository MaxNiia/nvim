return {

    {
        -- TODO: Look at actually using.
        "Shatur/neovim-session-manager",
        event = "VimEnter",
        opts = function()
            local config = require("session_manager.config")
            return {
                autoload_mode = config.AutoloadMode.Disabled,
            }
        end,
        config = function(_, opts)
            local session_manager = require("session_manager").setup(opts)

            local config_group = vim.api.nvim_create_augroup("SessionGroup", {})
            local function load_callback() end
            if _G.neotree then
                function load_callback()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                    require("oil").open(vim.loop.cwd())
                end
            elseif _G.mini_files then
                function load_callback()
                    require("mini.files").open(nil, false)
                end
            end

            vim.api.nvim_create_autocmd({ "User" }, {
                pattern = "SessionLoadPost",
                group = config_group,
                callback = load_callback,
            })

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                group = config_group,
                callback = function()
                    if
                        vim.bo.filetype ~= "git"
                        and not vim.bo.filetype ~= "gitcommit"
                        and not vim.bo.filetype ~= "gitrebase"
                        and not vim.bo.filetype ~= ""
                    then
                        session_manager.autosave_session()
                    end
                end,
            })
        end,
    },
}
