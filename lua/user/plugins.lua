local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Testing my plugins
  -- use "~/Documents/Projects/nvim-preview-svg"
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "kyazdani42/nvim-web-devicons" -- Set icons for everything in NeoVim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins, necessary for LSP
  use "folke/which-key.nvim" -- Correctly select keys for mapping
  use "bronson/vim-trailing-whitespace" -- Show trailing whitespaces in red
  use "akinsho/toggleterm.nvim" -- Add floating terminals feat
  use "kyazdani42/nvim-tree.lua" -- All the visualization tree settings
  use "nvim-lualine/lualine.nvim" -- Add inteligent Status Line
  use "lukas-reineke/indent-blankline.nvim" -- Inteligent indentation
  use {"https://github.com/rieg-ec/coc-tailwindcss", run = "yarn install --frozen-lockfile && yarn run build"} -- TailwindCSS by RIEG
  use "tpope/vim-commentary" -- Comment lines using gcc
  use "mxw/vim-jsx" -- Highlight JSX
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }) -- MarkDown browser preview
  use "nmassardot/nvim-preview-svg" -- Preview SVGs contained in files

  -- Buffers
  use "akinsho/bufferline.nvim" -- Show buffers in a line
  use "moll/vim-bbye" -- Delete buffers wisely

  -- Git
  use "lewis6991/gitsigns.nvim"
  -- use "github/copilot.vim"

  -- CMP
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"

  -- COC
  use {'neoclide/coc.nvim', branch = 'release'}

  -- Colorschema
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use {"sonph/onehalf", rtp="vim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
