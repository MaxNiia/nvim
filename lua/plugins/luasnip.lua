return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "molleweide/LuaSnip-snippets.nvim",
        },
        lazy = true,
        build = "make install_jsregexp",
        opts = {
            history = true,
            region_check_events = "InsertEnter",
            delete_check_events = "TextChanged,InsertLeave",
        },
        config = function(_, opts)
            if opts then
                require("luasnip").config.setup(opts)
            end

            require("luasnip.loaders.from_lua").load({
                paths = vim.fn.expand("~/.config/nvim/lua/luasnippets/"),
            })

            vim.tbl_map(function(type)
                require("luasnip.loaders.from_" .. type).lazy_load()
            end, { "vscode", "snipmate", "lua" })
        end,
    },
}
