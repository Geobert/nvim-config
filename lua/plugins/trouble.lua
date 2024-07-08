return {
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            use_diagnostic_signs = true,
            signs = {
                error = "",
                warning = "",
                hint = "",
                information = "",
                other = "﫠",
            },
            modes = {
                lsp = {
                    win = { position = "left" },
                },
                symbols = {
                    win = { position = "left" },
                },
            },
        },
    },
}
