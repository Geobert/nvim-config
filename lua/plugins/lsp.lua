return {
    -- require("plugins.lspsaga"),
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = false },
        },
    },
    -- {
    --     "aznhe21/actions-preview.nvim",
    --     opts = function()
    --         return {
    --             diff = {
    --                 algorithm = "patience",
    --                 ignore_whitespace = true,
    --             },
    --             telescope = require("telescope.themes").get_dropdown({ winblend = 5 }),
    --         }
    --     end,
    -- },
    -- "antosha417/nvim-lsp-file-operations",
    -- "onsails/lspkind.nvim",
}
