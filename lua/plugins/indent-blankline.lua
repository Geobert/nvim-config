return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = function()
            local highlight = {
                "indent_level_1",
                "indent_level_2",
                "indent_level_3",
                "indent_level_4",
                "indent_level_5",
                "indent_level_6",
            }
            local hooks = require("ibl.hooks")

            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "indent_level_1", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "indent_level_2", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "indent_level_3", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "indent_level_4", { fg = "#56B6C2" })
                vim.api.nvim_set_hl(0, "indent_level_5", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "indent_level_6", { fg = "#C678DD" })
                -- Set current position with bold effect
            end)
            vim.g.rainbow_delimiters = { highlight = highlight }
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
            return {
                indent = {
                    char = {
                        "┃",
                        "|",
                        "╏",
                        "╎",
                        "┇",
                        "┆",
                        "┋",
                        "┊",
                    },
                    tab_char = "",
                    highlight = highlight,
                },
                scope = {
                    highlight = highlight,
                    char = {
                        "░",
                    },
                    show_exact_scope = true,
                },
            }
        end,
    },
}
