return {
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_style = "atlantis"
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_dim_inactive_windows = true
      vim.cmd.colorscheme("sonokai")
    end,
  },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "sonokai",
  --   },
  -- },
}
