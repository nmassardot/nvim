local M = {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  event = "InsertEnter",
}

function M.config()
  require("blink.cmp").setup {
    keymap = {
      preset = "none",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-h>"] = { "show_documentation", "hide_documentation", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
      ghost_text = { enabled = true },
      menu = {
        border = "rounded",
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
        },
      },
      list = {
        selection = { preselect = true, auto_insert = false },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    cmdline = {
      enabled = true,
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  }
end

return M
