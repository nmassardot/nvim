local M = {
  "oxfist/night-owl.nvim",
  name = "night-owl",
  priority = 1000,
  lazy = false,
}

function M.config()
  require("night-owl").setup({
    transparent = false,
    italic_comments = true,
    bold_functions = true,
    bold_keywords = true,
    bold_conditionals = true,
  })

  vim.cmd.colorscheme "night-owl"
end

return M
