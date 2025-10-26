package.preload["nvim-web-devicons"] = function()
    require("mini.icons").mock_nvim_web_devicons()
    return package.loaded["nvim-web-devicons"]
end

local gen_loader = require("mini.snippets").gen_loader
local snippets = {
    gen_loader.from_file("~/.config/nvim/snippets/global.json"),
    gen_loader.from_lang(),
}

if vim.g.extra_snippets ~= nil then
    snippets = vim.tbl_deep_extend("force", snippets, vim.g.extra_snippets(gen_loader))
end

require("mini.snippets").setup({
    snippets = snippets,
    mappings = {
        expand = "",
        jump_next = "",
        jump_prev = "",
        stop = "",
    },
})

local make_stop = function()
    local au_opts = { pattern = "*:n", once = true }
    au_opts.callback = function()
        while MiniSnippets.session.get() do
            MiniSnippets.session.stop()
        end
    end
    vim.api.nvim_create_autocmd("ModeChanged", au_opts)
end

local opts = { pattern = "MiniSnippetsSessionStart", callback = make_stop }
vim.api.nvim_create_autocmd("User", opts)

require("mini.move").setup()
require("mini.splitjoin").setup()
require("mini.icons").setup({
    file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
    },
    filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
    },
})
require("mini.ai").setup({
    n_lines = 500,
})
require("mini.bracketed").setup({
    comment = {
        suffix = "z",
    },
})
require("mini.comment").setup({
    options = {
        custom_commentstring = nil,
        ignore_blank_line = true,
    },
})
require("mini.surround").setup({
    custom_surroundings = {
        ["("] = {
            input = { "%b()", "^.().*().$" },
            output = { left = "(", right = ")" },
        },
        ["["] = {
            input = { "%b[]", "^.().*().$" },
            output = { left = "[", right = "]" },
        },
        ["{"] = {
            input = { "%b{}", "^.().*().$" },
            output = { left = "{", right = "}" },
        },
        ["<"] = {
            input = { "%b<>", "^.().*().$" },
            output = { left = "<", right = ">" },
        },
    },
})
require("mini.cursorword").setup()
require("mini.align").setup()
require("mini.move").setup()
require("mini.pairs").setup()
