return {
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = "atlantis"
            vim.g.sonokai_enable_italic = 1
            vim.g.sonokai_dim_inactive_windows = 1
            vim.g.sonokai_better_performance = 1
            -- vim.g.sonokai_float_style = "dim"
            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("custom_highlights_sonokai", {}),
                pattern = "sonokai",
                callback = function()
                    local config = vim.fn["sonokai#get_configuration"]()
                    local palette = vim.fn["sonokai#get_palette"](config.style, config.colors_override)
                    local set_hl = vim.fn["sonokai#highlight"]

                    set_hl("MatchParen", palette.orange, palette.bg4)
                end,
            })
            vim.cmd.colorscheme("sonokai")
        end,
    },
    -- {
    --   "LazyVim/LazyVim",
    --   opts = {
    --     colorscheme = "sonokai",
    --   },
    -- },
}
