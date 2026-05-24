return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      integrations = {
        telescope = { enabled = true },
        neotree = { enabled = true },
        indent_blankline = { enabled = true },
      },
    },
  },
}
