return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "moyiz/blink-emoji.nvim",
        },
        opts = {
            completion = {
                ghost_text = { enabled = false },
                menu = {
                    auto_show = function(ctx)
                        return vim.bo.filetype ~= "markdown"
                    end,
                },
            },
            sources = {
                default = { "lsp", "snippets", "path", "emoji", "buffer" },
                providers = {
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15, -- Tune by preference
                        opts = { insert = true }, -- Insert emoji (default) or complete its name
                        should_show_items = function()
                            return vim.tbl_contains(
                                -- Enable emoji completion only for git commits and markdown.
                                -- By default, enabled for all file-types.
                                { "gitcommit", "markdown" },
                                vim.o.filetype
                            )
                        end,
                    },
                },
            },
        },
    },
}
