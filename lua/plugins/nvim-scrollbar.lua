return {
    {
        "petertriho/nvim-scrollbar",
        dependencies = {
            "kevinhwang91/nvim-hlslens",
            "lewis6991/gitsigns.nvim",
        },
        opts = {
            handle = {
                cursor = true,
                diagnostic = false,
                gitsigns = true, -- Requires gitsigns
                handle = true,
                search = true, -- Requires hlslens
                ale = false, -- Requires ALE
                text = " ",
                blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
                -- color = nil,
                -- color_nr = nil, -- cterm
                highlight = "Visual",
                hide_if_all_visible = true, -- Hides handle if all lines are visible
            },
        },
        config = function(_, opts)
            require("scrollbar").setup(opts)
            require("scrollbar.handlers.search").setup({
                override_lens = function() end,
            })
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },
}
