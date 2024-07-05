return {
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                width = 0.85, -- width of the Zen window
                height = 1, -- height of the Zen window
                options = {
                    signcolumn = "yes", -- disable signcolumn
                    number = true, -- disable number column
                    relativenumber = true, -- disable relative numbers
                    foldcolumn = "0", -- disable fold column
                    list = false, -- disable whitespace characters
                },
                plugins = {
                    twilight = false, -- enable twilight plugin
                },
            },
        },
    },
}
