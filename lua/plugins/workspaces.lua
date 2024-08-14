return {
    {
        "natecraddock/workspaces.nvim",
        opts = {
            auto_open = true,
            auto_dir = true,
            hooks = {
                open = function()
                    require("persistence").load()
                end,
            },
        },
    },
}
