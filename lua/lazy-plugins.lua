--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
require("lazy").setup({
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

    -- Use `opts = {}` to force a plugin to be loaded.
    --
    --  This is equivalent to:
    --    require('Comment').setup({})

    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },
    { "petertriho/nvim-scrollbar", opts = {} },

    { "blueyed/vim-diminactive" },
    { "stevearc/dressing.nvim" },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    { "ryanoasis/vim-devicons" },
    { "norcalli/nvim-colorizer.lua" },
    { "folke/twilight.nvim" },
    -- {
    --     "2kabhishek/termim.nvim",
    --     cmd = { "Fterm", "FTerm", "Sterm", "STerm", "Vterm", "VTerm" },
    -- },
    require("plugins.auto-hlsearch"),
    require("plugins.gitsigns"),
    require("plugins.which-key"),
    require("plugins.rust"),
    require("plugins.conform"),
    require("plugins.lsp"),
    require("plugins.theme"),
    require("plugins.todo"),
    require("plugins.mini"),
    require("plugins.treesitter"),
    require("plugins.autopairs"),
    require("plugins.indent-blankline"),
    require("plugins.smoothcursor"),
    require("plugins.lualine"),
    require("plugins.nvim-navic"),
    require("plugins.noice"),
    require("plugins.headlines"),
    require("plugins.live-command"),
    require("plugins.flash"),
    require("plugins.coloful-winsep"),
    require("plugins.trouble"),
    -- require("plugins.nvim-hlslens"),
    require("plugins.cmp"),
    require("plugins.telescope"),
    require("plugins.lazygit"),

    -- NOTE add plugins above this
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Faont icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})
