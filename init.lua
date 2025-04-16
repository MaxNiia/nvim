if
    vim.loop.os_uname().sysname == "Linux"
    and os.getenv("USER") == "max"
    and vim.fn.getcwd() == vim.fn.expand("$HOME")
then
    vim.env.GIT_DIR = vim.fn.expand("$HOME/.cfg")
    vim.env.GIT_WORK_TREE = vim.fn.expand("$HOME")
    vim.g.fugitive_git_executable = "/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME"
end

if vim.g.vscode == nil then
    vim.g.vscode = false
    vim.g.clipboard = {
        name = "win32yank",
        copy = {
            ["+"] = vim.fn.expand("$HOME/.local/bin/win32yank.exe") .. " -i --crlf",
            ["*"] = vim.fn.expand("$HOME/.local/bin/win32yank.exe") .. " -i --crlf",
        },
        paste = {
            ["+"] = vim.fn.expand("$HOME/.local/bin/win32yank.exe") .. " -o --lf",
            ["*"] = vim.fn.expand("$HOME/.local/bin/win32yank.exe") .. " -o --lf",
        },
        cache_enabled = true,
    }
end

require("niia").start()
