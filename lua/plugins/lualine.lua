return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local navic = require("nvim-navic")
            local signs = { error = " ", warn = " ", info = " ", hint = "⚡" }
            return {
                options = {
                    globalstatus = true,
                    icons_enabled = true,
                    theme = "auto",
                },
                tabline = {
                    lualine_y = {
                        {
                            "tabs",
                            tab_max_length = 40,
                            max_length = vim.o.columns / 1.5,
                            mode = 2,
                            use_mode_colors = true,
                            tabs_color = {
                                -- Same values as the general color option can be used here.
                                active = "lualine_a_visual", -- Color for active tab.
                                inactive = "lualine_a_inactive", -- Color for inactive tab.
                            },
                            fmt = function(name, context)
                                -- Show + if buffer is modified in tab
                                local buflist = vim.fn.tabpagebuflist(context.tabnr)
                                local winnr = vim.fn.tabpagewinnr(context.tabnr)
                                local bufnr = buflist[winnr]
                                local mod = vim.fn.getbufvar(bufnr, "&mod")

                                return name .. (mod == 1 and " Δ" or "")
                            end,
                        },
                    },
                },
                winbar = {
                    lualine_a = {
                        {
                            "filename",
                            path = 1,
                            shorting_target = 40,
                            symbols = {
                                modified = "[+]",
                                readonly = "🔒", -- Text to show when the file is non-modifiable or readonly.
                                unnamed = "[No Name]", -- Text to show for unnamed buffers.
                                newfile = "[New]", -- Text to show for newly created file before first write
                            },
                        },
                    },
                    lualine_c = {
                        {
                            "filetype",
                            icon_only = true,
                        },
                    },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_z = {
                        {
                            "filename",
                            path = 1,
                            symbols = {
                                modified = "✍️", -- Text to show when the file is modified.
                                readonly = "🔒", -- Text to show when the file is non-modifiable or readonly.
                                unnamed = "[No Name]", -- Text to show for unnamed buffers.
                                newfile = "[New]", -- Text to show for newly created file before first write
                            },
                        },
                    },
                },
                extensions = {
                    -- "aerial",
                    -- "nvim-tree",
                    "toggleterm",
                    "trouble",
                    "quickfix",
                    "lazy",
                    "fzf",
                    "fugitive",
                },
                sections = {
                    lualine_a = {
                        "mode",
                    },
                    lualine_b = {
                        {
                            "diagnostics",
                            icons_enabled = true,
                            symbols = signs,
                        },
                        {
                            function()
                                return vim.fn["db_ui#statusline"]({
                                    show = {
                                        "db_name",
                                        "schema",
                                        "table",
                                    },
                                    separator = " > ",
                                    prefix = " ",
                                })
                            end,
                        },
                    },
                    lualine_c = {
                        "diff",
                        { navic.get_location, cond = navic.is_available },
                    },
                    lualine_x = {
                        {
                            require("noice").api.status.search.get,
                            cond = require("noice").api.status.search.has,
                            color = { fg = "#ff9e64" },
                        },
                        {
                            "filetype",
                            icon_only = true,
                        },
                    },
                    lualine_y = {
                        { "branch" },
                        {
                            "progress",
                        },
                    },
                    lualine_z = {
                        "location",
                    },
                },
            }
        end,
    },
}
