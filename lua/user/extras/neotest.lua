local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-treesitter/nvim-treesitter",
    -- general tests
    "vim-test/vim-test",
    "nvim-neotest/neotest-vim-test",
    -- language specific tests
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "rouge8/neotest-rust",
    "lawrence-laz/neotest-zig",
    "rcasia/neotest-bash",
    "olimorris/neotest-rspec",
  },
}

function M.config()
  local wk = require "which-key"
  wk.register({
    ["<leader>t"] = {
      name = "Test",
      t = { "<cmd>lua require'neotest'.run.run()<cr>", "Test Nearest" },
      f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Test File" },
      d = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Test" },
      s = { "<cmd>lua require('neotest').run.stop()<cr>", "Test Stop" },
      a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach Test" },
    },
  })

  ---@diagnostic disable: missing-fields
  require("neotest").setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
      },
      require "neotest-vitest",
      require "neotest-zig",
      require "neotest-rust",
      require("neotest-rspec")({
        rspec_cmd = function()
          return vim.tbl_flatten({
            "bundle",
            "exec",
            "rspec",
          })
        end,
        transform_spec_path = function(path)
          return path
        end,
        results_path = "tmp/rspec.output",
      }),
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua", "javascript", "typescript", "ruby" },
      },
    },
    -- Recommended settings from neotest-rspec README
    discovery = {
      enabled = true,
    },
    output = {
      enabled = true,
      open_on_run = true,
    },
    quickfix = {
      enabled = true,
      open = false,
    },
    status = {
      enabled = true,
      signs = true,
      virtual_text = true,
    },
    summary = {
      enabled = true,
      expand_errors = true,
      follow = true,
      mappings = {
        attach = "a",
        clear_marked = "M",
        clear_target = "T",
        debug = "d",
        debug_marked = "D",
        expand = { "<CR>", "<2-LeftMouse>" },
        expand_all = "e",
        jumpto = "i",
        mark = "m",
        next_failed = "J",
        output = "o",
        prev_failed = "K",
        run = "r",
        run_marked = "R",
        short = "O",
        stop = "u",
        target = "t"
      },
    },
  }
end

return M
