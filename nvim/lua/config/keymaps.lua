local map = vim.keymap.set

vim.g.mapleader = " "
local opts = { noremap = true, silent = true }

-- ========================
-- FILE / SEARCH
-- ========================
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)

-- ========================
-- DEV DOC
-- ========================
----------------------------------------------------
-- 1. LSP hover (primary docs)
----------------------------------------------------
map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover Docs" })

----------------------------------------------------
-- 2. Telescope document search (global fuzzy docs)
----------------------------------------------------
map("n", "<leader>dd", function()
  require("telescope.builtin").live_grep({
    prompt_title = "Search Docs / Codebase",
  })
end, { desc = "Telescope docs search" })

----------------------------------------------------
-- 3. DevDocs fallback (web docs)
----------------------------------------------------
local function open_devdocs(query)
  local url = "https://devdocs.io/#q=" .. vim.fn.escape(query, " ")
  vim.fn.system({ "open", url }) -- macOS
end

map("n", "<leader>dw", function()
  open_devdocs(vim.fn.expand("<cword>"))
end, { desc = "DevDocs word under cursor" })

map("n", "<leader>ds", function()
  local q = vim.fn.input("DevDocs Search: ")
  if q ~= "" then
    open_devdocs(q)
  end
end, { desc = "DevDocs search prompt" })

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
map("n", "gd", function()
  vim.lsp.buf.definition()
end, opts)
map("n", "gr", function()
  vim.lsp.buf.references()
end, opts)
map("n", "gi", function()
  vim.lsp.buf.implementation()
end, opts)
map("n", "<leader>o", "<C-o>", opts)
map("n", "<leader>i", "<C-i>", opts)
map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, opts)
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, opts)
map("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, opts)

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

map("n", "<leader>uz", function()
  vim.g.focus_mode = not vim.g.focus_mode
  local on = not vim.g.focus_mode

  -- completion
  vim.g.blink_cmp_enabled = on

  -- lsp diagnostics
  if on then
    vim.diagnostic.enable()
  else
    vim.diagnostic.enable(false)
  end

  -- syntax / treesitter
  if on then
    vim.cmd("syntax enable")
    pcall(vim.treesitter.start, 0)
  else
    vim.cmd("syntax off")
    pcall(vim.treesitter.stop, 0)
  end

  vim.notify("Lock in mode " .. (vim.g.focus_mode and "on" or "off"))
end, { noremap = true, silent = true, desc = "Toggle lock in mode (no LSP/lint/colors/completion)" })
