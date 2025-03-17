-- Core Editor Settings
vim.opt.fileencoding = "utf-8" -- File encoding
vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.termguicolors = true -- Enable true color support
vim.opt.guifont = "monospace:h17" -- Font for GUI applications

-- UI Settings
vim.opt.showmode = false -- Hide mode indicator (-- INSERT --)
vim.opt.showtabline = 1 -- Always show tabline
vim.opt.laststatus = 3 -- Global statusline
vim.opt.showcmd = false -- Hide command line
vim.opt.ruler = false -- Hide ruler
vim.opt.cursorline = true -- Highlight current line
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = false -- Disable relative line numbers
vim.opt.numberwidth = 4 -- Width of line number column
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.wrap = false -- No line wrapping
vim.opt.scrolloff = 0 -- Lines of context when scrolling
vim.opt.sidescrolloff = 8 -- Columns of context when scrolling horizontally
vim.opt.title = true -- Show window title
vim.opt.titlelen = 0 -- Don't shorten title

-- Search Settings
vim.opt.hlsearch = true -- Highlight search matches
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive when capital letters are used
vim.opt.incsearch = true -- Show incremental search results
vim.opt.inccommand = "split" -- Show live preview of substitutions

-- Indentation and Tabs
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 2 -- Number of spaces for indentation
vim.opt.tabstop = 2 -- Number of spaces a tab counts for
vim.opt.smartindent = true -- Smart indentation

-- Window Management
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right

-- Performance Settings
vim.opt.lazyredraw = true -- Don't redraw while executing macros
vim.opt.updatetime = 100 -- Faster completion (4000ms default)
vim.opt.timeoutlen = 1000 -- Time to wait for mapped sequence
vim.opt.foldmethod = "syntax" -- Enable syntax-based code folding

-- Backup and Swap Files
vim.opt.backup = true -- Enable backup files
vim.opt.backupdir = vim.fn.stdpath("data") .. "/backup" -- Backup directory
vim.opt.swapfile = true -- Enable swap files
vim.opt.directory = vim.fn.stdpath("data") .. "/swap" -- Swap directory
vim.opt.writebackup = false -- Don't write backup if file is modified by another program
vim.opt.undofile = true -- Enable persistent undo

-- Completion Settings
vim.opt.completeopt = { "menuone", "noselect" } -- Completion menu behavior
vim.opt.pumheight = 10 -- Maximum number of items in completion menu
vim.opt.pumblend = 10 -- Transparency of completion menu

-- Visual Settings
vim.opt.conceallevel = 0 -- Show concealed characters
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.cmdheight = 1 -- Command line height
vim.opt.errorbells = false -- Disable error bells
vim.opt.visualbell = true -- Use visual bell instead of beeping

-- UI Customization
vim.opt.fillchars = vim.opt.fillchars + "eob: " -- Remove end of buffer characters
vim.opt.fillchars:append {
  stl = " ", -- Remove status line characters
}

-- Additional Settings
vim.opt.shortmess:append "c" -- Don't show completion menu messages
vim.cmd "set whichwrap+=<,>,[,],h,l" -- Allow cursor to wrap around
vim.cmd [[set iskeyword+=-]] -- Add hyphen to word characters
vim.cmd [[set iskeyword+=_]] -- Add underscore to word characters

-- Netrw Settings
vim.g.netrw_banner = 0 -- Hide Netrw banner
vim.g.netrw_mouse = 2 -- Enable mouse in Netrw
