local M = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
}

function M.config()
  require("snacks").setup {
    dashboard = {
      enabled = true,
      preset = {
        header = [[
 ★  ✯   🛸                    🪐   .°•    |
    __     ° ★  •       🛰       __      / \
   / /   ____ ___  ______  _____/ /_    | O |
  / /   / __ `/ / / / __ \/ ___/ __ \   | O |
 / /___/ /_/ / /_/ / / / / /__/ / / /  /| | |\
/_____/\__,_/\__,_/_/ /_/\___/_/ /_/  /_(.|.)_\]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua require('telescope.builtin').find_files()" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua require('telescope.builtin').oldfiles()" },
          { icon = " ", key = "t", desc = "Find Text", action = ":lua require('telescope.builtin').live_grep()" },
          { icon = " ", key = "c", desc = "Config", action = ":e ~/.config/nvim/init.lua" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    indent = {
      enabled = true,
      char = "▏",
      scope = {
        enabled = true,
        hl = "Comment",
      },
    },
    words = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    gitbrowse = { enabled = true },
  }

  -- Filter out noisy notifications
  local original_notify = vim.notify
  vim.notify = function(msg, ...)
    if msg == "No information available" then return end
    return original_notify(msg, ...)
  end

  -- Keymaps
  local wk = require "which-key"
  wk.add {
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Browse in GitHub" },
  }
end

return M
