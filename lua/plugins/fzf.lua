return {
    {
        "ibhagwan/fzf-lua",
        opts = function(_, opts)
            return {
                defaults = {
                    formatter = "path.filename_first",
                },
            }
        end,
    },
}
