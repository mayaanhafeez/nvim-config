-- Used by the hinterlands theme. The Omarchy theme repo ships a neovim.lua that
-- passes base16 keys (base00..base0F); aether.nvim v3 takes semantic keys
-- instead, so the repo's role assignments are translated below — each comment
-- names the base16 slot it came from. Values not covered by base16 come from
-- the theme's colors.toml.
return {
  {
    "bjarneo/aether.nvim",
    name = "aether",
    enabled = false,
    priority = 1000,
    opts = {
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
      colors = {
        accent               = "#686868",
        cursor               = "#ffffff",
        foreground           = "#ffffff",
        background           = "#222222",
        selection_foreground = "#ffffff",
        selection_background = "#686868",

        bg         = "#222222", -- base00 default background
        dark_bg    = "#1a1a1a",
        darker_bg  = "#141414",
        lighter_bg = "#525252", -- base01 lighter background (status bars)
        selection  = "#686868", -- colors.toml selection_background
        muted      = "#525252", -- base03 comments, invisibles
        dark_fg    = "#b9b9b9", -- base04 dark foreground
        fg         = "#ffffff", -- base05 default foreground
        light_fg   = "#ffffff", -- base06 light foreground
        bright_fg  = "#ffffff",

        red    = "#7c7c7c", -- base08 variables, errors
        orange = "#7c7c7c", -- base09 integers, constants
        yellow = "#a0a0a0", -- base0A classes, types
        green  = "#8b8b8b", -- base0B strings
        cyan   = "#868686", -- base0C support, regex
        blue   = "#686868", -- base0D functions, keywords
        purple = "#747474", -- base0E keywords, storage
        brown  = "#a0a0a0", -- base0F deprecated

        bright_red    = "#7c7c7c",
        bright_yellow = "#a0a0a0",
        bright_green  = "#8b8b8b",
        bright_cyan   = "#868686",
        bright_blue   = "#686868",
        bright_purple = "#747474",
      },
    },
  },
}
