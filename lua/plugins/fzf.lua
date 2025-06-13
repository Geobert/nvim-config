return {
    {
        "ibhagwan/fzf-lua",
        enabled = false,
        opts = function(_, opts)
            return {
                defaults = {
                    formatter = "path.filename_first",
                },
            }
        end,
    },
}
