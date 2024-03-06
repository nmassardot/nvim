local M = {
  "nvimtools/none-ls.nvim",
}

function M.config()
  local null_ls = require "null-ls"

  local formatting = null_ls.builtins.formatting

  null_ls.setup {
    debug = true,
    sources = {
      formatting.stylua,
      formatting.prettier,
      -- formatting.prettier.with {
      --   extra_filetypes = { "toml" },
      --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      -- },
      formatting.eslint,
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.completion.spell,
      null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.black.with {
        extra_args = { "--line-length=120" },
      },
      null_ls.builtins.formatting.terraform_fmt,
    },
  }
end

return M
