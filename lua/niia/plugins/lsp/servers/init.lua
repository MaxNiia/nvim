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
    azure_pipelines_ls = require("niia.plugins.lsp.servers.azure_pipelines_ls"),
    bashls = {},
    bzl = require("niia.plugins.lsp.servers.bzl"),
    basedpyright = require("niia.plugins.lsp.servers.basedPyright"),
    clangd = require("niia.plugins.lsp.servers.clangd"),
    cssls = require("niia.plugins.lsp.servers.cssls"),
    neocmake = {},
    cssmodules_ls = {},
    gopls = {},
    ols = {
        init_options = {
            checker_args = "-strict-style",
            collections = {
                { name = "shared", path = vim.fn.expand("$HOME/odin-lib") },
            },
        },
    },
    dockerls = {},
    jsonls = {},
    lua_ls = require("niia.plugins.lsp.servers.lua_ls"),
    marksman = {},
    rust_analyzer = require("niia.plugins.lsp.servers.rust_analyzer"),
    ts_ls = require("niia.plugins.lsp.servers.tsserver"),
    gdscript = {
        name = "godot",
        cmd = { "ncat", "localhost", "6005" },
        filetypes = { "gd", "gdscript", "gdscript3" },
        -- root_dir = function()
        --     return vim.fs.dirname(vim.fs.find("project.godot", { upward = true })[1])
        -- end,
        mason = false,
    },
    ruff = require("niia.plugins.lsp.servers.ruff"),
    -- yamlls = require("niia.plugins.lsp.servers.yamlls"),
}
