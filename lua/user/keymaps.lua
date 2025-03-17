local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key to space and local leader
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Preserve Ctrl-i for jump list navigation
keymap("n", "<C-i>", "<C-i>", opts)

-- Window Navigation
-- Use Ctrl + hjkl to move between windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- Switch to alternate file
keymap("n", "<m-tab>", "<c-6>", opts)

-- Search Navigation
-- Center the screen on search results
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Indentation
-- Keep selection when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Paste without yanking
keymap("x", "p", [["_dP]])

-- LSP Context Menu
-- Right-click menu for LSP actions
vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

-- Context Menu Triggers
vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- Line Navigation
-- Move through wrapped lines
keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)

-- Tab Management
-- Create new tab with current buffer
keymap("n", "<s-tab>", "<cmd>tabnew %<cr>", opts)
-- Navigate between tabs
keymap({ "n" }, "<s-h>", "<cmd>tabp<cr>", opts)
keymap({ "n" }, "<s-l>", "<cmd>tabn<cr>", opts)

-- Terminal Mode
-- Exit terminal mode with Ctrl-;
vim.api.nvim_set_keymap("t", "<C-;>", "<C-\\><C-n>", opts)
