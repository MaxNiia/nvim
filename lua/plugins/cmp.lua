return {
    {
        "tzachar/fuzzy.nvim",
        lazy = true,
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        lazy = true,
        config = function()
            require("copilot_cmp").setup()
        end,
    },
    {
        "hrsh7th/cmp-buffer",
        lazy = true,
        dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
    },
    {
        "paopaol/cmp-doxygen",
        lazy = true,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            -- "hrsh7th/cmp-copilot", Not truly supported
            "L3MON4D3/LuaSnip",
            "tzachar/fuzzy.nvim",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "petertriho/cmp-git",
            "hrsh7th/cmp-cmdline",
            {

                "paopaol/cmp-doxygen",
                dependencies = {
                    "nvim-treesitter/nvim-treesitter",
                    "nvim-treesitter/nvim-treesitter-textobjects",
                },
            },
        },
        config = function(_, _)
            -- luasnip setup
            local luasnip = require("luasnip")

            -- Lspkind
            local lspkind = require("lspkind")

            -- nvim-cmp setup
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    docuementation = cmp.config.window.bordered(),
                },
                experimental = {
                    ghost_text = true,
                },
                matching = {
                    disallow_fuzzy_matching = true,
                    disallow_fullfuzzy_matching = true,
                    disallow_partial_fuzzy_matching = true,
                    disallow_partial_matching = true,
                    disallow_prefix_unmatching = false,
                },
                sorting = {

                    priority_weight = 2,
                    comparators = {
                        -- Below is the default comparator list and order for nvim-cmp
                        require("copilot_cmp.comparators").prioritize,
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                formatting = {
                    format = function(entry, vim_item)
                        if vim.tbl_contains({ "path" }, entry.source.name) then
                            local icon, hl_group = require("nvim-web-devicons").get_icon(
                                entry:get_completion_item().label
                            )
                            if icon then
                                vim_item.kind = icon
                                vim_item.kind_hl_group = hl_group
                                return vim_item
                            end
                        end
                        return lspkind.cmp_format({
                            mode = "symbol", -- show only symbol annotations
                            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                            ellipsis_char = "...",
                            symbol_map = {
                                Text = "󰉿",
                                Method = "󰆧",
                                Function = "󰊕",
                                Constructor = "",
                                Field = "󰜢",
                                Variable = "󰀫",
                                Class = "󰠱",
                                Interface = "",
                                Module = "",
                                Property = "󰜢",
                                Unit = "󰑭",
                                Value = "󰎠",
                                Enum = "",
                                Keyword = "󰌋",
                                Snippet = "",
                                Color = "󰏘",
                                File = "󰈙",
                                Reference = "󰈇",
                                Folder = "󰉋",
                                EnumMember = "",
                                Constant = "󰏿",
                                Struct = "󰙅",
                                Event = "",
                                Operator = "󰆕",
                                TypeParameter = "",
                                Copilot = "",
                            },
                        })(entry, vim_item)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<c-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<c-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    -- Copilot Source
                    { name = "copilot", group_index = 2 },
                    { name = "nvim_lsp", group_index = 2 },
                    { name = "nvim_lsp_signature_help", group_index = 3 },
                    { name = "doxygen", group_index = 3 },
                    { name = "treesitter", group_index = 3 },
                    { name = "luasnip", group_index = 3 },
                    { name = "fuzzy_buffer", group_index = 3 },
                }, {
                    {
                        name = "buffer",
                        option = {
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs()
                            end,
                        },
                    },
                }),
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                }, {
                    { name = "buffer" },
                }),
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "nvim_lsp_document_symbol" },
                }, {
                    { name = "buffer" },
                }),
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
            })

            require("cmp_git").setup()
        end,
    },
}
