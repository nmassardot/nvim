local M = {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>rf", "<cmd>Refactor extract<cr>", mode = "v", desc = "Extract Function" },
    { "<leader>rv", "<cmd>Refactor extract_var<cr>", mode = "v", desc = "Extract Variable" },
    { "<leader>ri", "<cmd>Refactor inline_var<cr>", mode = { "n", "v" }, desc = "Inline Variable" },
    { "<leader>rI", function() require("refactoring").refactor("Inline Function") end, desc = "Inline Function" },
    { "<leader>rb", function() require("refactoring").refactor("Extract Block") end, desc = "Extract Block" },
  },
  opts = {},
}

return M
