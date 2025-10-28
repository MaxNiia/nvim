local M = {}

local function switch_source_header(bufnr, client)
    local method_name = 'textDocument/switchSourceHeader'
    ---@diagnostic disable-next-line:param-type-mismatch
    if not client or not client:supports_method(method_name) then
        return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
    end
    local params = vim.lsp.util.make_text_document_params(bufnr)
    ---@diagnostic disable-next-line:param-type-mismatch
    client:request(method_name, params, function(err, result)
        if err then
            error(tostring(err))
        end
        if not result then
            vim.notify('corresponding file cannot be determined')
            return
        end
        vim.cmd.edit(vim.uri_to_fname(result))
    end, bufnr)
end

local function symbol_info(bufnr, client)
    local method_name = 'textDocument/symbolInfo'
    ---@diagnostic disable-next-line:param-type-mismatch
    if not client or not client:supports_method(method_name) then
        return vim.notify('Clangd client not found', vim.log.levels.ERROR)
    end
    local win = vim.api.nvim_get_current_win()
    local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
    ---@diagnostic disable-next-line:param-type-mismatch
    client:request(method_name, params, function(err, res)
        if err or #res == 0 then
            -- Clangd always returns an error, there is no reason to parse it
            return
        end
        local container = string.format('container: %s', res[1].containerName) ---@type string
        local name = string.format('name: %s', res[1].name) ---@type string
        vim.lsp.util.open_floating_preview({ name, container }, '', {
            height = 2,
            width = math.max(string.len(name), string.len(container)),
            focusable = false,
            focus = false,
            title = 'Symbol Info',
        })
    end, bufnr)
end

local setup_lsps = function()
    vim.lsp.config('*', {
        root_markers = { '.git', '.hg' },
    })
    vim.lsp.enable({ "lua_ls", "clangd", "typos_lsp", "basedpyright", "dockerls", "jsonls", "marksman",
        "azure-pipeline-ls", "cmake", "starlark", })
end

local setup_diagnostics = function()
    local diagnostics = require("icons").diagnostics
    for type, icon in pairs(diagnostics) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, {
            text = icon,
            texthl = hl, --[[numhl = hl]]
        })
    end

    vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_lines = vim.fn.has("nvim-0.11") and {
            current_line = true,
        } or false,
        virtual_text = false,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = diagnostics.Error,
                [vim.diagnostic.severity.WARN] = diagnostics.Warn,
                [vim.diagnostic.severity.HINT] = diagnostics.Hint,
                [vim.diagnostic.severity.INFO] = diagnostics.Info,
            },
        },
    })
end

M.init = function()
    setup_lsps()
    setup_diagnostics()

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            if client == nil then
                return
            end
            if client.name == "ast_grep" then
                return
            end

            -- Enable completion triggered by <c-x><c-o>
            if client:supports_method('textDocument/completion') then
                vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
            end

            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"

            if client:supports_method('textDocument/formatting') then
                vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr(#{timeout_ms:250})'

                if not client:supports_method('textDocument/willSaveWaitUntil') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                        buffer = args.buf,
                        callback = function()
                            if vim.b.autoformat and vim.g.autoformat then
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000, async = true, })
                            end
                        end,
                    })
                end
            end

            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end

            if client:supports_method("textDocument/documentColor") then
                vim.lsp.document_color.enable(true, args.buf, {
                    style = "virtual",
                })
            end

            -- Codelens
            if client.server_capabilities.codeLensProvider then
                vim.lsp.codelens.refresh()
                vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                    buffer = bufnr,
                    callback = vim.lsp.codelens.refresh,
                })
            end

            -- Mappings
            vim.keymap.set("n", "qK", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })
            vim.keymap.set({ "n", "v" }, "grc", vim.lsp.codelens.run, { buffer = bufnr, desc = "Run Codelens" })
            vim.keymap.set("n", "grC", vim.lsp.codelens.refresh, { buffer = bufnr, desc = "Refresh & DisplayCodelens" })
            vim.keymap.set("n", "grd", vim.lsp.buf.format, { buffer = bufnr, desc = "Refresh & DisplayCodelens" })

            if client.name == "clangd" then
                vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
                    switch_source_header(bufnr, client)
                end, { desc = "Switch between source/header" })

                vim.api.nvim_buf_create_user_command(bufnr, "LspClangdShowSymbolInfo", function()
                    symbol_info(bufnr, client)
                end, { desc = "Show symbol info" })

            vim.keymap.set("n", "<leader>o", "<cmd>LspClangdSwitchSourceHeader<cr>", { buffer = bufnr, desc = "Switch Header/Source" })
            end
        end,
    })
end


local has_blink, blink = pcall(require, "blink.cmp")
local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_blink and blink.get_lsp_capabilities() or {}
)

capabilities.offsetEncoding = { "utf-16" }
capabilities.semanticTokensProvider = nil
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

M.capabilities = capabilities

return M
