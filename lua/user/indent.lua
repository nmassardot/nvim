local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
}

function M.config()
  require("ibl").setup {
    indent = {
      char = "▏", -- This is a slightly thinner vertical line
    },
    whitespace = {
      highlight = highlight,
      remove_blankline_trail = false,
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
      injected_languages = true,
      highlight = highlight,
      priority = 500,
    },
  }
end

return M 
