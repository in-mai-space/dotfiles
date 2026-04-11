local map = vim.keymap.set

vim.g.mapleader = " "
local opts = { noremap = true, silent = true }

-- ========================
-- FILE / SEARCH
-- ========================
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)

-- ========================
-- BUFFERS
-- ========================
map("n", "<leader>bd", "<cmd>bd<CR>", opts)
map("n", "<leader>bn", "<cmd>bnext<CR>", opts)
map("n", "<leader>bp", "<cmd>bprevious<CR>", opts) 

-- ========================
-- FILE EXPLORER
-- ========================
map("n", "<leader>e", "<cmd>Ex<CR>", opts)

-- ========================
-- WINDOW NAVIGATION
-- ========================
map("n", "<leader>l", "<C-w>h", opts)
map("n", "<leader>b", "<C-w>j", opts)
map("n", "<leader>t", "<C-w>k", opts)
map("n", "<leader>r", "<C-w>l", opts)

-- ========================
-- LSP CORE
-- ========================
map("n", "gd", function() vim.lsp.buf.definition() end, opts)
map("n", "gr", function() vim.lsp.buf.references() end, opts)
map("n", "gi", function() vim.lsp.buf.implementation() end, opts)
map("n", "<leader>o", "<C-o>", opts)
map("n", "<leader>i", "<C-i>", opts)
map("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)

-- ========================
-- GIT (GITSIGNS)
-- ========================
map("n", "<leader>gs", "<cmd>Gitsigns toggle_signs<CR>", opts)
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", opts)
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", opts)

-- ========================
-- TERMINALS
-- ========================
map("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", opts)
map("n", "<leader>th", "<cmd>split | terminal<CR>", opts)

-- ========================
-- TOGGLES
-- ========================
map("n", "<leader>uc", function()
  vim.g.blink_cmp_enabled = not vim.g.blink_cmp_enabled
  vim.notify("Completion " .. (vim.g.blink_cmp_enabled and "enabled" or "disabled"))
end, opts)

map("n", "<leader>uh", function()
  vim.b.syntax_highlighting_enabled = vim.b.syntax_highlighting_enabled == false

  if vim.b.syntax_highlighting_enabled then
    vim.cmd("syntax enable")
    pcall(vim.treesitter.start)
  else
    vim.cmd("syntax off")
    pcall(vim.treesitter.stop)
  end

  vim.notify("Syntax highlighting " .. (vim.b.syntax_highlighting_enabled and "enabled" or "disabled"))
end, opts)
