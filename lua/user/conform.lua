local M = {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
}

function M.config()
  require("conform").setup {
    formatters_by_ft = {
      python = { "isort", "black" },
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
    },
    format_on_save = function(bufnr)
      -- Disable for certain filetypes
      local ignore_filetypes = { "sql" }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
  }

  -- Override <leader>lf to use conform
  local wk = require "which-key"
  wk.add {
    {
      "<leader>lf",
      function() require("conform").format { async = true, lsp_format = "fallback" } end,
      desc = "Format",
    },
  }
end

return M
