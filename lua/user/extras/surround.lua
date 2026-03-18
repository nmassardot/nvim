local M = {
  "kylechui/nvim-surround",
  version = "^3",
  event = "VeryLazy",
}

function M.config()
  require("nvim-surround").setup {}
end

return M
