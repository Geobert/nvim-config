-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

require("config.utils")
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_particle_density = 100.0
vim.o.guifont = "FiraCode Nerd Font:h12"

local opt = vim.opt
opt.spelllang = { "fr", "en_gb" }
opt.spell = true
opt.tabstop = 4
opt.conceallevel = 0
