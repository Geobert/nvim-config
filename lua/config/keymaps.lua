-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always map: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- [[ Basic Keymaps ]]
--  See `:help map()`
local map = vim.keymap.set
-- better up/down
map({ "n", "x" }, "+", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "-", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, ";", ",")
map({ "n", "x" }, ",", ";")
map({ "n", "x" }, "<C-c>", "<C-i>")

-- C-backspace to delete word in insert and command mode
map("i", "<C-BS>", "<C-W>")
map("c", "<C-BS>", "<C-W>")

-- toggle show white spaces
map("n", "<C-.>", "<cmd>set list!<CR>")
map("i", "<C-.>", "<cmd>set list!<CR>")

-- Move to window using the <alt> + arrow keys
map("n", "<A-Left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<A-Down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<A-Up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<A-Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Move Lines
map("n", "<S-Down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<S-Up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<S-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<S-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<S-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<S-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
