-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "write" })
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
    group = vim.api.nvim_create_augroup("FocusLostStuff", { clear = true }),
    callback = function(ev)
        vim.cmd.stopinsert()
        vim.cmd.wall({ mods = { silent = true } })
    end,
})
