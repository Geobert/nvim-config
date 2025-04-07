return {
    { -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VeryLazy", -- Sets the loading event to 'VimEnter'
        opts = {
            preset = "helix",
        },
        keys = {
            { "<leader>rp", "<cmd>ReindentP<CR>", desc = "Reindent Paragraph" },
            { "<leader>ra", "<cmd>ReindentAll<CR>", desc = "Reindent All" },
            { "<leader>cD", "<cmd>RustLsp openDocs<CR>", desc = "Open docs.rs" },
            -- { "<leader>fl", "<cmd>BrootCurrentDir<CR>", desc = "Open file manager at the current file" },
            -- { "<leader>fe", "<cmd>BrootWorkingDir<CR>", desc = "Open file manager at cwd" },
            {
                "<leader>fl",
                "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>",
                desc = "Open file manager at current file",
            },
            { "<leader>fe", "<cmd>lua MiniFiles.open()<CR>", desc = "Open file manager at cwd" },
            { "<leader>cb", "<cmd>BaconList<CR>", desc = "Bacon List" },
            { "<leader>cn", "<cmd>BaconLoad<CR>:w<CR><cmd>BaconNext<CR>", desc = "Bacon Next" },
        },
    },
}
