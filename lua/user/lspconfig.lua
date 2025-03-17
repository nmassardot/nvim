-- LSP Configuration Module
local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" }, -- Load on buffer read or new file
}

-- LSP Keymaps
-- Define keymaps for LSP functionality
local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  
  -- Navigation
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- Go to declaration
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- Go to definition
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- Go to implementation
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- Show references
  
  -- Help and Diagnostics
  keymap(bufnr, "n", "<CR>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- Show signature help
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- Show diagnostic float
  
  -- Smart hover with UFO integration
  vim.keymap.set("n", "K", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  end)
end

-- LSP Client Attach Handler
-- Configure client behavior when attaching to a buffer
M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  -- Enable inlay hints if supported
  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(true)
  end
  
  -- Special handling for Volar (Vue.js LSP)
  if client.name == "volar" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

-- Toggle Inlay Hints
M.toggle_inlay_hints = function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end

-- Common LSP Capabilities
-- Define standard capabilities for all LSP clients
function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  
  -- Completion capabilities
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  
  -- Folding capabilities
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

-- Main Configuration
function M.config()
  -- Which-key mappings for LSP commands
  local wk = require "which-key"
  wk.add {
    -- Code actions and formatting
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    {
      "<leader>lf",
      "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      desc = "Format",
    },
    
    -- Diagnostics and navigation
    {
      "<leader>lj",
      "<cmd>lua vim.diagnostic.goto_next()<cr>",
      desc = "Next Diagnostic",
    },
    {
      "<leader>lk",
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      desc = "Prev Diagnostic",
    },
    {
      "<leader>lq",
      "<cmd>lua vim.diagnostic.setloclist()<cr>",
      desc = "Quickfix",
    },
    
    -- LSP features
    {
      "<leader>li",
      "<cmd>LspInfo<cr>",
      desc = "Info",
    },
    {
      "<leader>lh",
      "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>",
      desc = "Hints",
    },
    {
      "<leader>ll",
      "<cmd>lua vim.lsp.codelens.run()<cr>",
      desc = "CodeLens Action",
    },
    {
      "<leader>lr",
      "<cmd>lua vim.lsp.buf.rename()<cr>",
      desc = "Rename",
    },
    
    -- Visual mode code actions
    {
      "<leader>la",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      desc = "Code Action",
      mode = { "v" },
    },
  }

  -- Configure LSP servers
  local lspconfig = require "lspconfig"
  local icons = require "user.icons"

  -- List of LSP servers to configure
  local servers = {
    "cssls",      -- CSS
    "html",       -- HTML
    "pyright",    -- Python
    "bashls",     -- Bash
    "jsonls",     -- JSON
    "solargraph", -- Ruby
    "yamlls",     -- YAML
    "marksman",   -- Markdown
    "tailwindcss", -- Tailwind CSS
    "volar",      -- Vue.js
    "eslint",     -- ESLint
    "ts_ls",     -- ESLint
  }

  -- Configure diagnostic display
  vim.diagnostic.config {
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
      },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      header = "",
      prefix = "",
    },
  }

  -- Configure LSP UI elements
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  -- Setup each LSP server
  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }

    -- Load server-specific settings if available
    local require_ok, settings = pcall(require, "user.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    lspconfig[server].setup(opts)

    -- Special handling for nginx LSP
    if server == "nginx-language-server" then
      require("lspconfig").nginx_language_server.setup(opts)
    end
  end
end

return M
