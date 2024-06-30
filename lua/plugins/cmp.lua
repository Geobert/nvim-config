return {
    { -- Autocompletion
        "hrsh7th/nvim-cmp",
        -- event = "InsertEnter",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },
            "saadparwaiz1/cmp_luasnip",

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "windwp/nvim-autopairs",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "dmitmel/cmp-cmdline-history",
            "chrisgrieser/cmp-nerdfont",
            "hrsh7th/cmp-emoji",
            "ray-x/cmp-treesitter",
            "lukas-reineke/cmp-rg",
            "f3fora/cmp-spell",
        },
        init = function()
            -- See `:help cmp`

            -- Set up lspconfig.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})
            local cmp_buffer = require("cmp_buffer")

            require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "cmdline" }, -- You can specify the `cmp_git` source if you were installed it.
                    { name = "path", group_index = 1 },
                    -- { name = "env", option = { eval_on_confirm = true }, group_index = 2 },
                    { name = "buffer", keyword_length = 3, group_index = 2 },
                    { name = "cmdline_history", group_index = 3 },
                },
            })

            cmp.setup.cmdline("/", {
                view = {
                    entries = {
                        name = "custom",
                        maxwidth = 50,
                        maxheight = 10,
                        separator = "||",
                    },
                },
                mapping = cmp.mapping.preset.cmdline(),
                sorting = {
                    comparators = {
                        function(...)
                            return cmp_buffer:compare_locality(...)
                        end,
                    },
                },
                sources = cmp.config.sources({
                    { name = "buffer", keyword_length = 1 },
                    { name = "rg", keyword_length = 3 },
                    { name = "path" },
                    { name = "treesitter" },
                }),
            })

            cmp.setup.cmdline("?", {
                view = {
                    entries = {
                        name = "custom",
                        maxwidth = 50,
                        maxheight = 10,
                        separator = "||",
                    },
                },
                mapping = cmp.mapping.preset.cmdline(),
                sorting = {
                    comparators = {
                        function(...)
                            return cmp_buffer:compare_locality(...)
                        end,
                    },
                },
                sources = cmp.config.sources({
                    { name = "buffer", keyword_length = 1, option = { keyword_pattern = [[\k\+]] } },
                    { name = "rg", keyword_length = 3 },
                    { name = "path" },
                    { name = "treesitter" },
                }),
            })
        end,

        opts = function()
            -- For cmp floating window
            local border = {
                { "╔", "FloatBorder" },
                { "═", "FloatBorder" },
                { "╗", "FloatBorder" },
                { "║", "FloatBorder" },
                { "╝", "FloatBorder" },
                { "═", "FloatBorder" },
                { "╚", "FloatBorder" },
                { "║", "FloatBorder" },
            }
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            return {
                preselect = cmp.PreselectMode.None,
                sorting = {
                    priority_weight = 5,
                    comparators = {
                        cmp.config.compare.score,
                        cmp.config.compare.exact,
                        cmp.config.compare.kind,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.offset,
                        -- Below is the default comparitor list and order for nvim-cmp
                        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                        cmp.config.compare.locality,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:Pmenu,CursorLine:PmenuSel",
                        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                    },
                    documentation = cmp.config.window.bordered(),
                },
                completion = { completeopt = "menu,menuone,noinsert,noselect", autocomplete = false },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    expandable_indicator = true,
                    format = function(entry, vim_item)
                        vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
                        local kind = require("lspkind").cmp_format({
                            mode = "symbol_text",
                            maxwidth = 50,
                            ellipsis_char = "…",
                            show_labelDetails = true,
                            symbol_map = {
                                Text = "",
                                Method = "",
                                Function = "",
                                Constructor = "",
                                Field = "",
                                Variable = "",
                                Class = "",
                                Interface = "",
                                Module = "",
                                Property = "",
                                Unit = "",
                                Value = "",
                                Enum = "",
                                Keyword = "",
                                Snippet = "",
                                Color = "",
                                File = "",
                                Reference = "",
                                Folder = "",
                                EnumMember = "",
                                Constant = "",
                                Struct = "",
                                Event = "",
                                Operator = "",
                                Copilot = "",
                                TypeParameter = "",
                            },
                        })(entry, vim_item)
                        return kind
                    end,
                },

                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                mapping = cmp.mapping.preset.insert({
                    -- Select the [n]ext item
                    ["<down>"] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ["<up>"] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [b]ack / [f]orward
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    -- ["<Tab>"] = cmp.mapping.confirm({ select = true }),

                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ["<C-Space>"] = cmp.mapping.complete({}),

                    -- Think of <
                    -- Think of <c-l> as moving to the right of your snippet expansion.
                    --  So if you have a snippet that's like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ["<C-l>"] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),

                    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", group_index = 1, max_item_count = 9 },
                    { name = "luasnip", group_index = 2, max_item_count = 3 },
                    { name = "path", group_index = 1, option = { trailing_slash = true } },
                    { name = "crates" },
                    { name = "nvim_lsp_signature_help", group_index = 1, max_item_count = 9 },
                    { name = "emoji" },
                    { name = "treesitter", group_index = 1, max_item_count = 9 },
                    { name = "nvim_lua", group_index = 1, max_item_count = 9 },
                    {
                        name = "buffer",
                        keyword_length = 3,
                        group_index = 2,
                        option = { keyword_pattern = [[\k\+]] },
                        max_item_count = 4,
                    },
                    {
                        name = "rg",
                        keyword_length = 3,
                        group_index = 3,
                        option = {
                            context_after = 5,
                            context_before = 3,
                            additional_arguments = { "--hidden", "--files", "--max-depth 2" },
                        },
                        max_item_count = 3,
                    },
                }),
                matching = {
                    disallow_fuzzy_matching = false,
                    disallow_fullfuzzy_matching = false,
                    disallow_partial_fuzzy_matching = false,
                    disallow_partial_matching = false,
                    disallow_prefix_unmatching = false,
                },
            }
        end,
    },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lua" },
    {
        "ray-x/lsp_signature.nvim",
        cond = true,
        event = "VeryLazy",
        opts = {
            bind = false,
            noice = false,
            hint_enable = false,
            max_height = 30,
            handlers_opts = {
                border = "shadow",
            },
        },
        config = function(_, opts)
            require("lsp_signature").setup(opts)
        end,
    },
    { "windwp/nvim-autopairs" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },
    { "dmitmel/cmp-cmdline-history" },
    { "chrisgrieser/cmp-nerdfont" },
    { "ray-x/cmp-treesitter" },
    { "lukas-reineke/cmp-rg" },
    { "f3fora/cmp-spell" },
    { "hrsh7th/cmp-emoji" },
}
