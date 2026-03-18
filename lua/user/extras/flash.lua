local M = {
  "folke/flash.nvim",
  event = "VeryLazy",
}

function M.config()
  require("flash").setup {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    modes = {
      char = {
        enabled = true,  -- enhances f/F/t/T with labels (replaces eyeliner)
      },
      search = {
        enabled = false, -- don't hijack regular /search
      },
    },
  }

  vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
  vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
end

return M
