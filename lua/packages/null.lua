local null_ls = require("null-ls")

local gitsigns = null_ls.builtins.code_actions.gitsigns.with({
   config = {
      filter_actions = function(title)
         return title:lower():match("blame") == nil -- filter out blame actions
      end,
   },
})

null_ls.setup({
   sources = {
      -- Lua
      null_ls.builtins.formatting.stylua,

      -- Cmake
      null_ls.builtins.diagnostics.cmake_lint,
      null_ls.builtins.formatting.cmake_format,

      -- Clang
      null_ls.builtins.diagnostics.clang_check,

      -- Python
      null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.formatting.autopep8,
      null_ls.builtins.formatting.black,

      -- Spelling
      null_ls.builtins.completion.spell,

      -- Refactoring
      null_ls.builtins.code_actions.refactoring,

      -- Rust
      null_ls.builtins.code_actions.ltrs,
      null_ls.builtins.formatting.rustfmt,

      -- Git
      null_ls.builtins.code_actions.gitrebase,
      null_ls.builtins.code_actions.gitsigns,
      gitsigns,
      null_ls.builtins.diagnostics.commitlint,
   },
})
