return {
    ast_grep = {},
    typos_lsp = {
        init_options = { -- Sent to the LSP on init
            diagnosticSeverity = "Hint",
        },
        filetypes = {
            "*",
        },
    },
    glsl_analyzer = {},
    azure_pipelines_ls = require("plugins.lsp.servers.azure_pipelines_ls"),
    bashls = {},
    bzl = require("plugins.lsp.servers.bzl"),
    basedpyright = require("plugins.lsp.servers.basedPyright"),
    clangd = require("plugins.lsp.servers.clangd"),
    cssls = require("plugins.lsp.servers.cssls"),
    cmake = {},
    cssmodules_ls = {},
    dockerls = {},
    jsonls = {},
    lua_ls = require("plugins.lsp.servers.lua_ls"),
    marksman = {},
    rust_analyzer = require("plugins.lsp.servers.rust_analyzer"),
    ts_ls = require("plugins.lsp.servers.tsserver"),
    ruff_lsp = require("plugins.lsp.servers.ruff"),
    -- yamlls = require("plugins.lsp.servers.yamlls"),
}
