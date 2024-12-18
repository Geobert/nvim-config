return {
    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = function()
            -- Add augroup command to auto set filetype as markdown in markdown file
            vim.cmd([[highlight Dash guibg=#D19A66 gui=bold]])
            return {
                markdown = {
                    headline_highlights = { "Headline" },
                    bullets = { "◉", "○", "✸", "✿" },
                    codeblock_highlight = "",
                    dash_highlight = "Dash",
                    dash_string = "-",
                    quote_highlight = "Quote",
                    quote_string = "┃",
                    fat_headlines = false,
                    fat_headline_upper_string = "▁",
                    fat_headline_lower_string = "▔",
                },
            }
        end,
    },
}
