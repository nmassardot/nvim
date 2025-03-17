local M = {
  "nvimtools/none-ls.nvim",
}

function M.config()
  local h = require "null-ls.helpers"
  local cmd_resolver = require "null-ls.helpers.command_resolver"
  local methods = require "null-ls.methods"
  local u = require "null-ls.utils"

  local FORMATTING = methods.internal.FORMATTING
  
  local null_ls = require "null-ls"

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup {
    debug = true,
    sources = {
      formatting.stylua,
      -- formatting.prettier,
      formatting.black,
      formatting.shfmt,
      formatting.sql_formatter,

      -- formatting.eslint,
      -- null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.completion.spell,
    },
  }
end

return M
