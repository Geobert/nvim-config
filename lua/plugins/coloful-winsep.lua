return {
    {
        "nvim-zh/colorful-winsep.nvim",
        config = true,
        event = { "WinNew" },
        opts = {
            --highlight for Window separator
            highlight = {
                bg = "#16161E",
                fg = "#41fdfe",
            },
            --timer refresh rate
            interval = 30,
            smooth = true,
            --This plugin will not be activated for filetype in the following table.
            no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree", "CommandLine" },
            --Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
            symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
            close_event = function()
                --Executed after closing the window separator
            end,
            create_event = function()
                --Executed after creating the window separator
            end,
        },
    },
}
