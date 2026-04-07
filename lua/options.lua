vim.g.have_nerd_font = true
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.o.findfunc = "v:lua.FdFind"
function _G.FdFind(pat)
    local result = vim.system({ "fd", "--type", "f", "--full-path", pat }, { text = true }):wait()
return vim.split(result.stdout, "\n", { trimempty = true })
end

vim.opt.wildignore = {
    ".DS_Store",
    "*.o",
    "*.a",
    "__pycache__",
    "node_modules",
    ".cache",
    "bazel-*",
    "build",
}

vim.o.autoindent = true
-- Ensures the menu appears even for a single match and uses the native popup window.
vim.o.autocomplete = true
vim.opt.completeopt = "menu,menuone,noselect,popup"
vim.opt.complete:append("o") -- include omnifunc (LSP) in autocomplete sources
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
vim.o.signcolumn = "yes:1"
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.number = true
vim.o.numberwidth = 2
vim.o.relativenumber = true
vim.o.shiftwidth = 0
vim.o.showbreak = "> "
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
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4
vim.o.updatetime = 250
vim.o.showmode = true

require('vim._core.ui2').enable({})

vim.opt.fillchars:append({
    diff =  "╱",
    foldopen =  "",
    foldclose =  "",
    foldsep = "│",
    fold = " ",
    stl = " ",
    stlnc = " ",
})
vim.o.list = true
vim.opt.listchars:append({
    tab = " ",
    trail = "",
    extends = "",
    precedes = "",
    nbsp =  "",
})
vim.opt.display:append({ "truncate" })
vim.opt.formatoptions:append({ "j" })
vim.opt.nrformats:remove({ "octal" })
vim.opt.sessionoptions:remove({ "options" })
vim.opt.sessionoptions:append({ "globals" })
vim.opt.viewoptions:remove({ "options" })
vim.wo.spell = true
local bg = (vim.env.NVIM_BACKGROUND or ""):lower()
if bg == "light" or bg == "dark" then
    vim.opt.background = bg
end
vim.opt.wildmode = "noselect"

vim.api.nvim_create_autocmd("CmdlineChanged", {
        pattern = {":", "/", "?"},
        callback = function ()
                vim.fn.wildtrigger()
        end
})
