-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set("n", "+", "j")
vim.keymap.set("n", "-", "k")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<S-up>", ":tabnew %<CR>")
vim.keymap.set("i", "<S-up>", ":tabnew %<CR>")
vim.keymap.set("n", "<S-down>", ":tabn<CR>")
vim.keymap.set("n", "<S-left>", ":tabp<CR>")
vim.keymap.set("n", "<S-right>", ":tabn<CR>")

-- C-backspace to delete word in insert and command mode
vim.keymap.set("i", "<C-BS>", "<C-W>")
vim.keymap.set("c", "<C-BS>", "<C-W>")

-- toggle spell checker
vim.keymap.set("n", "<F2>", "<cmd>set spell!<CR>")
vim.keymap.set("i", "<F2>", "<cmd>set spell!<CR>")

-- toggle show white spaces
vim.keymap.set("n", "<F3>", "<cmd>set list! list?<CR>")
vim.keymap.set("i", "<F3>", "<cmd>set list! list?<CR>")

-- remove search hightlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<A-left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<A-right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<A-down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<A-up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
