return {
    { "echasnovski/mini.pairs", enabled = false },
    -- { "stevearc/dressing.nvim" },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    { "ryanoasis/vim-devicons" },
    { "norcalli/nvim-colorizer.lua" },
    { "folke/twilight.nvim", enabled = false },
    { "HiPhish/rainbow-delimiters.nvim" },
    { "nvim-neo-tree/neo-tree.nvim", enabled = false },
    { "catppuccin/nvim", enabled = false },
    { "akinsho/bufferline.nvim", enabled = false },
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters = {
                ["markdownlint-cli2"] = {
                    args = { "--config", vim.fn.expand("~/markdownlint.yaml"), "--" },
                },
            },
        },
    },
}
