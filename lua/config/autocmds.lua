-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function is_saveable()
    return not (
        vim.bo.readonly
        or vim.api.nvim_buf_get_name(0) == ""
        or vim.bo.buftype ~= ""
        or not (vim.bo.modifiable and vim.bo.modified)
    )
end
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern = "*",
    callback = function()
        if is_saveable() then
            vim.cmd("silent w")
            vim.cmd("doau BufWritePost")
        end
    end,
})
vim.api.nvim_create_autocmd({ "FocusLost" }, {
    group = vim.api.nvim_create_augroup("FocusLostStuff", { clear = true }),
    callback = function()
        vim.cmd.stopinsert()
        vim.cmd.wall({ mods = { silent = true } })
    end,
})
vim.api.nvim_create_autocmd({ "BufLeave" }, {
    group = vim.api.nvim_create_augroup("BufLeaveStuff", { clear = true }),
    callback = function()
        vim.cmd.stopinsert()
        if is_saveable() then
            vim.cmd.write({ mods = { silent = true } })
        end
    end,
})
