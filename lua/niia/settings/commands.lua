vim.api.nvim_create_user_command("Browse", function(opts)
    local url = string.gsub(opts.fargs[1], "%%2F", "/")
    vim.cmd(string.format("!xdg-open %q", url))
end, { nargs = 1 })
