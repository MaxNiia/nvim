if vim.fn.getcwd() == vim.fn.expand("$HOME") then
    vim.env.GIT_DIR = vim.fn.expand("$HOME/.cfg")
    vim.env.GIT_WORK_TREE = vim.fn.expand("$HOME")
    vim.g.fugitive_git_executable = "/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME"
end

require("niia").start()
