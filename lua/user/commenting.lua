local M = {
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = "VeryLazy",
}

function M.config()
  vim.g.skip_ts_context_commentstring_module = true

  ---@diagnostic disable: missing-fields
  require("ts_context_commentstring").setup {
    enable_autocmd = false,
  }

  -- Integrate with Neovim's native commenting (gc)
  local get_option = vim.filetype.get_option
  vim.filetype.get_option = function(filetype, option)
    return option == "commentstring"
      and require("ts_context_commentstring.internal").calculate_commentstring()
      or get_option(filetype, option)
  end

  -- Keep leader+/ shortcut
  local wk = require "which-key"
  wk.add {
    { "<leader>/", "gcc", desc = "Comment", hidden = true, remap = true },
    { "<leader>/", "gc", desc = "Comment", mode = "v", hidden = true, remap = true },
  }
end

return M
