-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

require("config.utils")
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_particle_density = 200.0
vim.g.neovide_hide_mouse_when_typing = true
vim.o.guifont = "FiraCode Nerd Font:h12"

local opt = vim.opt
opt.spelllang = { "fr", "en_gb" }
opt.spell = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.conceallevel = 0
opt.title = true
opt.titlestring = "%<%f %m"
opt.shell = "pwsh"
opt.shellcmdflag = "-Command "
opt.shellquote = ""
opt.shellxquote = ""
opt.shellpipe = "| Out-File -Encoding UTF8 "
opt.shellredir = "| Out-File -Encoding UTF8 "
