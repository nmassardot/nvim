local M = {
  "chrisgrieser/nvim-various-textobjs",
  lazy = false,
}

function M.config()
  require("various-textobjs").setup({
    keymaps = { useDefaults = true },
    lookForwardLines = 10,
  })

  -- Define your own keymaps
  local keymap_opts = { noremap = true, silent = true }
  
  -- Inner mappings
  vim.keymap.set({ "o", "x" }, "ii", '<cmd>lua require("various-textobjs").indentation(true, true)<CR>', keymap_opts)
  vim.keymap.set({ "o", "x" }, "ai", '<cmd>lua require("various-textobjs").indentation(false, true)<CR>', keymap_opts)
  vim.keymap.set({ "o", "x" }, "iS", '<cmd>lua require("various-textobjs").subword(true)<CR>', keymap_opts)
  vim.keymap.set({ "o", "x" }, "aS", '<cmd>lua require("various-textobjs").subword(false)<CR>', keymap_opts)
  vim.keymap.set({ "o", "x" }, "iC", '<cmd>lua require("various-textobjs").toNextClosingBracket(true)<CR>', keymap_opts)
  vim.keymap.set({ "o", "x" }, "aC", '<cmd>lua require("various-textobjs").toNextClosingBracket(false)<CR>', keymap_opts)
  
  -- Value mappings
  vim.keymap.set({ "o", "x" }, "iv", '<cmd>lua require("various-textobjs").value(true)<CR>', keymap_opts)
  vim.keymap.set({ "o", "x" }, "av", '<cmd>lua require("various-textobjs").value(false)<CR>', keymap_opts)
  
  -- Key mappings
  vim.keymap.set({ "o", "x" }, "ik", '<cmd>lua require("various-textobjs").key(true)<CR>', keymap_opts)
  vim.keymap.set({ "o", "x" }, "ak", '<cmd>lua require("various-textobjs").key(false)<CR>', keymap_opts)

  -- Number mappings
  vim.keymap.set({ "o", "x" }, "in", '<cmd>lua require("various-textobjs").number(true)<CR>', keymap_opts)
  vim.keymap.set({ "o", "x" }, "an", '<cmd>lua require("various-textobjs").number(false)<CR>', keymap_opts)

  -- Rest of line mappings
  vim.keymap.set({ "o", "x" }, "ir", '<cmd>lua require("various-textobjs").restOfLine(true)<CR>', keymap_opts)
  vim.keymap.set({ "o", "x" }, "ar", '<cmd>lua require("various-textobjs").restOfLine(false)<CR>', keymap_opts)
end

return M
