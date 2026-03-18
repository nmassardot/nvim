-- Telescope Configuration Module
local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true } },
  event = "VeryLazy",
}

function M.config()
  local wk = require "which-key"

  -- File Operations
  wk.add {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    { "<leader>fd", function() require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Find in current dir" },
    { "<leader>fr", function() require("telescope.builtin").oldfiles() end, desc = "Recent File" },
    { "<leader>bb", function() require("telescope.builtin").buffers({ previewer = false }) end, desc = "Find Buffers" },
  }

  -- Search Operations
  wk.add {
    { "<leader>ft", function() require("telescope.builtin").live_grep() end, desc = "Find Text" },
    { "<leader>fs", function() require("telescope.builtin").grep_string() end, desc = "Find String" },
    { "<leader>fl", function() require("telescope.builtin").resume() end, desc = "Last Search" },
  }

  -- Git Operations
  wk.add {
    {
      "<leader>go",
      function() require("telescope.builtin").git_status() end,
      desc = "Open changed file",
    },
    {
      "<leader>gb",
      function() require("telescope.builtin").git_branches() end,
      desc = "Checkout branch",
    },
    {
      "<leader>gc",
      function() require("telescope.builtin").git_commits() end,
      desc = "Checkout commit",
    },
    {
      "<leader>gC",
      function() require("telescope.builtin").git_bcommits() end,
      desc = "Checkout commit(for current file)",
    },
  }

  -- UI and Tools
  wk.add {
    { "<leader>fc", function() require("telescope.builtin").colorscheme() end, desc = "Colorscheme" },
    { "<leader>fk", function() require("telescope.builtin").keymaps() end, desc = "Keymaps" },
  }

  -- Customize Telescope Results Display
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopeResults",
    callback = function(ctx)
      vim.api.nvim_buf_call(ctx.buf, function()
        vim.fn.matchadd("TelescopeParent", "\t\t.*$")
        vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
      end)
    end,
  })

  -- Helper Functions
  local icons = require "user.icons"
  local actions = require "telescope.actions"

  -- Custom filename display function
  local function filenameFirst(_, path)
    local tail = vim.fs.basename(path)
    local parent = vim.fs.dirname(path)
    if parent == "." then
      return tail
    end
    return string.format("%s\t\t%s", tail, parent)
  end

  -- Telescope Setup
  require("telescope").setup {
    defaults = {
      -- UI Elements
      prompt_prefix = "🔍 ",
      selection_caret = "➜ ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },
      
      -- Layout Settings
      sorting_strategy = nil,
      layout_strategy = nil,
      layout_config = {},

      -- Search Settings
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--glob=!.git/",
      },

      -- Keymaps
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
        },
      },

      multi_icon = "✦",
    },

    -- Picker-specific Settings
    pickers = {
      -- File Search
      live_grep = {
        theme = "dropdown",
      },
      grep_string = {
        theme = "dropdown",
      },
      find_files = {
        theme = "dropdown",
        previewer = false,
        path_display = filenameFirst,
        find_command = { "rg", "--files", "--hidden", "--glob=!.git/*" },
        hidden = true,
        no_ignore = false,
        follow = true,
      },

      -- Buffer Management
      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },

      -- Theme and Colors
      colorscheme = {
        enable_preview = true,
      },

      -- LSP Pickers
      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
    },
    extensions = {
      -- Extension configurations would go here
    },
  }
end

return M
