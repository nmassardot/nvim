local M = {
  "notomo/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
}

function M.config()
  local capabilities = (function()
    local ok, blink = pcall(require, "blink.cmp")
    return ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()
  end)()

  require("typescript-tools").setup {
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    capabilities = capabilities,
    settings = {
      separate_diagnostic_server = true,
      expose_as_code_action = "all",
      tsserver_max_memory = "auto",
      include_completions_with_insert_text = true,
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "none",
        includeCompletionsForModuleExports = true,
        quotePreference = "auto",
      },
      jsx_close_tag = {
        enable = true,
        filetypes = { "javascriptreact", "typescriptreact", "vue" },
      },
    },
  }
end

return M
