-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

require("config.utils")
if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_cursor_vfx_particle_density = 50.0
    vim.g.neovide_hide_mouse_when_typing = true
end
vim.o.guifont = "Cascadia Code NF:h12.5"

local opt = vim.opt
opt.spelllang = { "fr", "en_gb" }
opt.spell = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.conceallevel = 0
opt.title = true
opt.titlestring = "%<%f %m"
-- opt.shell = "pwsh"
-- opt.shellcmdflag = "-Command "
-- opt.shellquote = ""
-- opt.shellxquote = ""
-- opt.shellpipe = "| Out-File -Encoding UTF8 "
-- opt.shellredir = "| Out-File -Encoding UTF8 "
vim.diagnostic.config({
    -- Use the default configuration
    -- virtual_lines = true,
    virtual_text = false,
    -- Alternatively, customize specific options
    virtual_lines = {
        -- Only show virtual line diagnostics for the current cursor line
        current_line = true,
    },
})
