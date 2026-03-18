local M = {
  "nvim-lualine/lualine.nvim",
}

function M.config()
  local icons = require "user.icons"

  local diagnostics = {
    "diagnostics",
    sections = { "error", "warn" },
    colored = false,
    always_visible = true,
  }

  local filetype = {
    function()
      local ft = vim.bo.filetype
      local upper_case_filetypes = {
        "json", "jsonc", "yaml", "toml", "css", "scss", "html", "xml",
      }
      if vim.tbl_contains(upper_case_filetypes, ft) then
        return ft:upper()
      end
      return ft
    end,
  }

  require("lualine").setup {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "NvimTree" },
    },
    sections = {
      lualine_a = {},
      lualine_b = { "branch" },
      lualine_c = { diagnostics, "filename" },
      lualine_x = { filetype },
      lualine_y = { "progress" },
      lualine_z = {},
    },
    extensions = { "quickfix", "man" },
  }
end

return M
