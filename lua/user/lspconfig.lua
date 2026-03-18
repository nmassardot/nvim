-- LSP Configuration Module
local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  -- K hover is handled by UFO (extras/ufo.lua)
end

M.toggle_inlay_hints = function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end

function M.config()
  local wk = require "which-key"
  wk.add {
    { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
    { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "v" } },
    { "<leader>lj", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
    { "<leader>lk", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
    { "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix" },
    { "<leader>li", "<cmd>checkhealth vim.lsp<cr>", desc = "Info" },
    { "<leader>lh", M.toggle_inlay_hints, desc = "Hints" },
    {
      "<leader>lr",
      function()
        local old = vim.fn.expand("<cword>")
        local new = vim.fn.input("Rename (buffer): ", old)
        if new == "" or new == old then return end
        vim.cmd(":%s/\\<" .. vim.fn.escape(old, "/\\") .. "\\>/" .. vim.fn.escape(new, "/\\") .. "/g")
      end,
      desc = "Rename (buffer)",
    },
  }

  local icons = require "user.icons"

  -- Servers to configure
  local servers = {
    "cssls",
    "html",
    "pyright",
    "bashls",
    "jsonls",
    "solargraph",
    "yamlls",
    "marksman",
    "tailwindcss",
    "volar",
    "eslint",
    "ts_ls",
  }

  -- Diagnostics
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

  -- Capabilities (blink.cmp + folding for UFO)
  local capabilities = (function()
    local status_ok, blink = pcall(require, "blink.cmp")
    local caps = status_ok
      and blink.get_lsp_capabilities()
      or vim.lsp.protocol.make_client_capabilities()
    caps.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    return caps
  end)()

  -- On attach
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local bufnr = args.buf

      lsp_keymaps(bufnr)

      if client and client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true)
      end

      if client and client.name == "volar" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
    end,
  })

  -- Configure and enable each server using vim.lsp.config (Neovim 0.11+)
  for _, server in ipairs(servers) do
    local opts = { capabilities = capabilities }

    -- Load server-specific settings if available
    local require_ok, settings = pcall(require, "user.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    vim.lsp.config(server, opts)
  end

  vim.lsp.enable(servers)
end

return M
