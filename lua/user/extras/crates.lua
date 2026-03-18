local M = {
  "saecki/crates.nvim",
}

function M.config()
  require("crates").setup {}
end

return M
