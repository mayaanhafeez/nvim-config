return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    enabled = false,
    priority = 1000,
    opts = {
      style = "night", -- "storm", "night", "moon", or "day"
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
