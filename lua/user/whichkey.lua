local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local mappings = {
    ["q"] = { "<cmd>confirm q<CR>", "Quit" },
    ["w"] = { "<cmd>confirm w<CR>", "Save" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    ["y"] = { "<cmd>CellularAutomaton make_it_rain<CR>", "Yup" },
    -- ["s"] = { "<cmd><CR>", "Explorer" },
    -- ["x"] = { "<cmd>Trouble<CR>", "Diagnostics" },
    [";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
    ["v"] = { "<cmd>vsplit<CR>", "Split" },
    ["o"] = { "<cmd>Navbuddy<cr>", "Nav" },
    b = {
      name = "Buffers",
      -- j = { "<cmd>BufferLinePick<cr>", "Jump" },
      b = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
      -- b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
      -- n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
      e = {
        "<cmd>BufferLinePickClose<cr>",
        "Pick which buffer to close",
      },
      D = {
        "<cmd>BufferLineSortByDirectory<cr>",
        "Sort by directory",
      },
      L = {
        "<cmd>BufferLineSortByExtension<cr>",
        "Sort by language",
      },
    },
    p = {
      name = "Plugins",
      i = { "<cmd>Lazy install<cr>", "Install" },
      s = { "<cmd>Lazy sync<cr>", "Sync" },
      S = { "<cmd>Lazy clear<cr>", "Status" },
      c = { "<cmd>Lazy clean<cr>", "Clean" },
      u = { "<cmd>Lazy update<cr>", "Update" },
      p = { "<cmd>Lazy profile<cr>", "Profile" },
      l = { "<cmd>Lazy log<cr>", "Log" },
      d = { "<cmd>Lazy debug<cr>", "Debug" },
    },

    c = {
      name = "JavaScript",
      -- s = { '<cmd>lua require("package-info").show()<cr>', "Show package info" },
      -- h = { '<cmd>lua require("package-info").hide()<cr>', "Hide package info" },
      g = { '<cmd>lua require("package-info").toggle()<cr>', "Toggle package info" },
      u = { '<cmd>lua require("package-info").update()<cr>', "Update package" },
      x = { '<cmd>lua require("package-info").delete()<cr>', "Delete package" },
      -- i = { '<cmd>lua require("package-info").install()<cr>', "Install package" },
      v = { '<cmd>lua require("package-info").change_version()<cr>', "Change Version" },
      s = { "<cmd>TSToolsSortImports<cr>", "Sort imports" },
      o = { "<cmd>TSToolsOrganizeImports<cr>", "Organize imports" },
      f = { "<cmd>TSToolsFixAll<cr>", "Fix all" },
      i = { "<cmd>TSToolsAddMissingImports<cr>", "Add imports" },
      d = { "<cmd>TSToolsGoToSourceDefinition<cr>", "Source definition" },
      r = { "<cmd>TSToolsRenameFile<cr>", "Rename file" },
      t = { "<cmd>TSC<cr>", "TSC" },
    },

    f = {
      name = "Find",
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      f = { "<cmd>Telescope find_files<cr>", "Find files" },
      p = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
      t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
      s = { "<cmd>Telescope grep_string<cr>", "Find String" },
      h = { "<cmd>Telescope help_tags<cr>", "Help" },
      H = { "<cmd>Telescope highlights<cr>", "Highlights" },
      i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
      l = { "<cmd>Telescope resume<cr>", "Last Search" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
    },

    g = {
      name = "Git",
      j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo Stage Hunk",
      },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      y = { "<cmd>GitLink!<cr>", "Git link" },
      Y = { "<cmd>GitLink! blam<cr>", "Git link blame" },
      C = {
        "<cmd>Telescope git_bcommits<cr>",
        "Checkout commit(for current file)",
      },
      d = {
        "<cmd>Gitsigns diffthis HEAD<cr>",
        "Git Diff",
      },
    },

    -- vim.lsp.buf.format {
    -- filter = function(client) return client.name ~= "tsserver" end
    -- }

    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = { "<cmd>Trouble<cr>", "Diagnostics" },
      -- d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
      -- w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      -- f = { "<cmd>lua vim.lsp.buf.format({timeout_ms = 1000000})<cr>", "Format" },
      f = {
        "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
        "Format",
      },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>Mason<cr>", "Mason Info" },
      j = {
        "<cmd>lua vim.diagnostic.goto_next()<cr>",
        "Next Diagnostic",
      },
      h = { "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>", "Hints" },
      k = {
        "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        "Prev Diagnostic",
      },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
      },
      t = { "<cmd>TodoTrouble<cr>", "TODO" },
      e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
    },

    t = {
      name = "Tab",
      t = {
        "<cmd>lua require('telescope').extensions['telescope-tabs'].list_tabs(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Tabs'})<cr>",
        "Find Tab",
      },
      -- [";"] = { "<cmd>$tabnew<cr>", "New Empty Tab" },
      a = { "<cmd>$tabnew<cr>", "New Empty Tab" },
      A = { "<cmd>tabnew %<cr>", "New Tab" },
      n = { "<cmd>tabn<cr>", "Next" },
      o = { "<cmd>tabonly<cr>", "Only" },
      p = { "<cmd>tabp<cr>", "Prev" },
      h = { "<cmd>-tabmove<cr>", "Move Left" },
      l = { "<cmd>+tabmove<cr>", "Move Right" },
    },

    T = {
      name = "Treesitter",
      i = { ":TSConfigInfo<cr>", "Info" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd
  local vmappings = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    },
  }

  local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local which_key = require "which-key"

  which_key.setup {
    plugins = {
      marks = false, -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true,
        suggestions = 20,
      }, -- use which-key for spelling hints
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = false, -- bindings for folds, spelling and others prefixed with z
        g = false, -- bindings for prefixed with g
      },
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by default for Telescope
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end

return M
