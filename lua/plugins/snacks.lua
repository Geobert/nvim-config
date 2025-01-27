return {
    "folke/snacks.nvim",
    opts = {
        lazygit = {},
        bigfile = {},
        scroll = { enabled = false },
        zen = {
            toggles = {
                dim = false,
                git_signs = true,
                mini_diff_signs = false,
            },
            show = { statusline = false, tabline = false },
            win = { backdrop = { transparent = false } },
        },
        -- styles = { zen = { backdrop = { transparent = false, blend = 0 } } },
    },
}
