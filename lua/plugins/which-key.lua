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
            { "<leader>ff", "<cmd>BrootCurrentDir<CR>", desc = "Open file manager at the current file" },
            { "<leader>fe", "<cmd>BrootWorkingDir<CR>", desc = "Open file manager at cwd" },
        },
    },
}
