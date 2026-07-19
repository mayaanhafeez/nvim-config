return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    enabled = true,
    priority = 1000,
    opts = {
      style = "storm", -- "storm", "night", "moon", or "day"
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
