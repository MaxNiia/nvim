local icons = require("icons")

vim.g.have_nerd_font = true

-- Ensure yazi behaves correctly
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Disable unneeded providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.b.autoformat = true

vim.opt.wildignore = {
    ".DS_Store",
    "*.o",
    "*.a",
    "__pycache__",
    "node_modules",
    ".cache",
    "bazel-*",
}

-- Indentation
vim.o.autoindent = true

-- Disable autocomplete as it interferes with snacks.picker.
vim.o.autocomplete = false

-- Disable most completion as blink handles it.
vim.opt.completeopt = {
    "menuone",
    "noselect",
    "noinsert",
}

vim.o.pumheight = 15
vim.o.pumborder = "rounded"
vim.o.autoread = true
vim.o.autowrite = true
vim.o.autowriteall = true
vim.o.backspace = "indent,eol,start"
vim.o.belloff = "all"
vim.o.colorcolumn = "+1"
vim.o.cursorline = true
vim.o.cursorlineopt = "both"
vim.opt.diffopt = {
    "inline:char",
    "filler",
    "internal",
    "closeoff",
    "algorithm:histogram",
    "context:99",
    "linematch:60",
    "indent-heuristic",
}
vim.o.expandtab = true
vim.o.exrc = true
vim.o.foldcolumn = "auto:1"
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.number = true
vim.o.numberwidth = 2
vim.o.relativenumber = true
vim.o.shiftwidth = 0
vim.o.showbreak = ""
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.smoothscroll = true
vim.o.softtabstop = 4
vim.o.spell = true
vim.o.spelloptions = "camel"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 8
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.title = true
vim.o.ttimeout = true
vim.o.ttimeoutlen = 10
vim.o.linebreak = true
vim.o.undofile = true
vim.opt.mousescroll = { "ver:3", "hor:0" }
vim.o.winborder = "rounded"
vim.o.wildmenu = true
vim.o.winblend = 0
vim.o.laststatus = 3
vim.o.showcmdloc = "statusline"
vim.o.cmdheight = 1
vim.o.pumheight = 10
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4
vim.o.updatetime = 250
vim.o.showmode = false

vim.opt.fillchars:append({
    diff = icons.misc.slash,
    foldopen = icons.fold.open,
    foldclose = icons.fold.closed,
    foldsep = icons.fold.separator,
    fold = " ",
    stl = " ",
    stlnc = " ",
})
vim.opt.listchars:append({
    tab = icons.chevron.right .. " ",
    trail = icons.misc.minus,
    extends = icons.chevron.right,
    precedes = icons.chevron.left,
    nbsp = icons.misc.plus,
})
vim.opt.display:append({ "truncate" })
vim.opt.formatoptions:append({ "j" })
vim.opt.complete:remove({ "truncate" })
vim.opt.nrformats:remove({ "octal" })
vim.opt.sessionoptions:remove({ "options" })
vim.opt.sessionoptions:append({ "globals" })
vim.opt.viewoptions:remove({ "options" })

-- Window
vim.wo.spell = true

local bg = (vim.env.NVIM_BACKGROUND or ""):lower()
if bg == "light" or bg == "dark" then
    vim.opt.background = bg
end

local settings = {}

---@class options.SettingConfig
---@field name string
---@field default_value string|integer|boolean|table
---@field description string

---@param config options.SettingConfig
local setting = function(config)
    if vim.g[config.name] == nil then
        vim.g[config.name] = config.default_value
    end

    table.insert(settings, config)
end

-- SCREAM case is for config wide settings (saved in shada).
-- Pascal case is for project wide settings (saved in session).

setting({
    name = "special_dirs",
    default_value = {
        WORKSPACE = vim.fn.expand("~/workspace/dev/"),
        NOTES = vim.fn.expand("~/Documents/notes/"),
    },
    description = "Table of string which will replace the path when in file paths, in the winbar.",
})

setting({
    name = "notes_directory",
    default_value = vim.fn.expand("~/Documents/notes/"),
    description = "Where to place notes."
})

setting({
    name = "clangd_query_driver",
    default_value = "/usr/bin/clang, /usr/bin/clang++",
    description = "Query driver for clangd, where clangd retrieves standard library symbols from."
})

setting({
    name = "copyright_text",
    default_value = {
        "Copyright",
        "Year: {YEAR}",
    },
    description = "Text to insert when copyright is invoked."
})

vim.g.available_settings = settings
