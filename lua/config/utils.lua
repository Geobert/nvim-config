local M = {}

M.preserve = function(arguments)
    local arguments = string.format("keepjumps keeppatterns execute %q", arguments)
    -- local original_cursor = vim.fn.winsaveview()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_command(arguments)
    local lastline = vim.fn.line("$")
    -- vim.fn.winrestview(original_cursor)
    if line > lastline then
        line = lastline
    end
    vim.api.nvim_win_set_cursor(0, { line, col })
end

vim.cmd([[command! ReindentAll lua require('config.utils').preserve("sil keepj normal! gg=G")]])
vim.cmd([[command! ReindentP lua require('config.utils').preserve("sil keepj normal! gwap")]])
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.md" },
    callback = function()
        require("blink.cmp.completion.windows.menu").auto_show = false
    end,
})
return M
