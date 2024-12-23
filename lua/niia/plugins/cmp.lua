return {}
-- local has_words_before = function()
--     if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
--         return false
--     end
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0
--         and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$")
--             == nil
-- end
-- return {
--     {
--         "zbirenbaum/copilot-cmp",
--         lazy = true,
--         config = function()
--             require("copilot_cmp").setup({
--                 fix_pairs = false,
--             })
--         end,
--     },
--     {
--         "hrsh7th/nvim-cmp",
--         event = "InsertEnter",
--         dependencies = {
--             "hrsh7th/cmp-nvim-lsp",
--             "hrsh7th/cmp-buffer",
--             "hrsh7th/cmp-nvim-lsp-document-symbol",
--             "hrsh7th/cmp-nvim-lsp-signature-help",
--             "hrsh7th/cmp-path",
--             "hrsh7th/cmp-cmdline",
--             {

--                 "paopaol/cmp-doxygen",
--                 dependencies = {
--                     "nvim-treesitter/nvim-treesitter",
--                     "nvim-treesitter/nvim-treesitter-textobjects",
--                 },
--             },
--         },
--         config = function(_, _)
--             require("niia.snippets").register_cmp_source()
--             -- nvim-cmp setup
--             local cmp = require("cmp")
--             cmp.setup({
--                 view = {
--                     entries = {
--                         follow_cursor = true,
--                         selection_order = "top_down",
--                     },
--                 },
--                 window = {
--                     completion = cmp.config.window.bordered({ border = "none" }),
--                     documentation = cmp.config.window.bordered({ border = "none" }),
--                 },
--                 experimental = {
--                     ghost_text = true,
--                 },
--                 matching = {
--                     disallow_fuzzy_matching = true,
--                     disallow_fullfuzzy_matching = true,
--                     disallow_partial_fuzzy_matching = true,
--                     disallow_partial_matching = true,
--                     disallow_prefix_unmatching = false,
--                     disallow_symbol_nonprefix_matching = false,
--                 },
--                 sorting = {
--                     priority_weight = 2,
--                     comparators = {
--                         require("copilot_cmp.comparators").prioritize,
--                         -- Below is the default comparator list and order for nvim-cmp
--                         require("clangd_extensions.cmp_scores"),
--                         cmp.config.compare.offset,
--                         cmp.config.compare.exact,
--                         -- cmp.config.compare.scopes,
--                         cmp.config.compare.score,
--                         cmp.config.compare.recently_used,
--                         cmp.config.compare.locality,
--                         cmp.config.compare.kind,
--                         cmp.config.compare.sort_text,
--                         cmp.config.compare.length,
--                         cmp.config.compare.order,
--                     },
--                 },
--                 formatting = {
--                     format = function(_, vim_item)
--                         local icon, hl = MiniIcons.get("lsp", vim_item.kind)
--                         vim_item.kind = icon .. " " .. vim_item.kind
--                         vim_item.kind_hl_group = hl
--                         return vim_item
--                     end,
--                 },
--                 mapping = cmp.mapping.preset.insert({
--                     ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--                     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--                     ["<C-Space>"] = cmp.mapping.complete(),
--                     ["<CR>"] = cmp.mapping.confirm({
--                         behavior = cmp.ConfirmBehavior.Replace,
--                         select = true,
--                     }),
--                     ["<c-n>"] = cmp.mapping(function(fallback)
--                         if cmp.visible() then
--                             cmp.select_next_item()
--                         else
--                             fallback()
--                         end
--                     end, { "i", "s" }),
--                     ["<Tab>"] = vim.schedule_wrap(function(fallback)
--                         if cmp.visible() and has_words_before() then
--                             cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
--                         else
--                             fallback()
--                         end
--                     end),
--                     ["<c-p>"] = cmp.mapping(function(fallback)
--                         if cmp.visible() then
--                             cmp.select_prev_item()
--                         else
--                             fallback()
--                         end
--                     end, { "i", "s" }),
--                     ["<S-Tab>"] = cmp.mapping(function(fallback)
--                         if cmp.visible() then
--                             cmp.select_prev_item()
--                         else
--                             fallback()
--                         end
--                     end, { "i", "s" }),
--                 }),
--                 sources = cmp.config.sources({
--                     { name = "lazydev", group_index = 0 },
--                     { name = "nvim_lsp_signature_help", group_index = 0 },
--                     { name = "snp", group_index = 1 },
--                     { name = "doxygen", group_index = 1 },
--                     { name = "nvim_lsp", group_index = 2 },
--                     { name = "copilot", group_index = 2 },
--                     { name = "treesitter", group_index = 3, max_item_count = 5 },
--                     { name = "fuzzy_buffer", group_index = 3, max_item_count = 5 },
--                 }, {
--                     -- {
--                     --     name = "buffer",
--                     --     option = {
--                     --         get_bufnrs = function()
--                     --             return vim.api.nvim_list_bufs()
--                     --         end,
--                     --     },
--                     -- },
--                 }),
--             })

--             -- Set configuration for specific filetype.
--             cmp.setup.filetype("gitcommit", {
--                 sources = cmp.config.sources({}, {
--                     { name = "buffer" },
--                 }),
--             })

--             -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
--             cmp.setup.cmdline({ "/", "?" }, {
--                 mapping = cmp.mapping.preset.cmdline(),
--                 sources = cmp.config.sources({
--                     { name = "nvim_lsp_document_symbol" },
--                 }, {
--                     { name = "buffer" },
--                 }),
--             })

--             -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--             cmp.setup.cmdline(":", {
--                 mapping = cmp.mapping.preset.cmdline(),
--                 sources = cmp.config.sources({
--                     {
--                         name = "cmdline",
--                         option = {
--                             ignore_cmds = { "Man", "!", "TermExec", "set makeprg", "Dispatch" },
--                         },
--                     },
--                 }, {
--                     { name = "path" },
--                 }),
--             })
--         end,
--     },
-- }
