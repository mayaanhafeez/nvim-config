-- Colorscheme selection, Omarchy-style.
--
-- Omarchy keeps the active system theme's lazy spec in its current-theme
-- directory and rewrites it on every `omarchy theme set`. Loading that file is
-- exactly what Omarchy's own lua/plugins/theme.lua symlink does; a plain file is
-- used here instead so this config survives being pushed to git and pulled onto
-- a machine (macOS) that has no Omarchy state to point at.
--
-- On Omarchy: nvim follows the system theme, nothing to configure.
-- Elsewhere: FALLBACK below picks the theme.

-- Omarchy 4 moved the current-theme directory from ~/.config/omarchy to
-- ~/.local/state/omarchy. Its upgrade relocates the old directory rather than
-- leaving a copy behind, so at most one of these exists and the first hit is
-- always the live one.
local OMARCHY_THEMES = {
  "~/.local/state/omarchy/current/theme/neovim.lua",
  "~/.config/omarchy/current/theme/neovim.lua",
}

-- Only consulted when Omarchy is absent. Must be a key of `local_themes`.
local FALLBACK = "tokyonight-night"

-- Colorscheme tuning, keyed by plugin repo. Merged under the active spec's own
-- opts (so an Omarchy theme's generated palette still wins) and only for
-- plugins the active theme actually declares, so nothing unused gets installed.
local tweaks = {
  ["rose-pine/neovim"] = {
    variant = "main", -- "main", "moon", or "dawn"
    dark_variant = "main",
    dim_inactive_windows = false,
    extend_background_behind_borders = true,
    styles = {
      bold = true,
      italic = true,
      transparency = false,
    },
    groups = {
      border = "muted",
      link = "iris",
      panel = "surface",
    },
  },
  ["folke/tokyonight.nvim"] = {
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      sidebars = "transparent",
      floats = "transparent",
    },
  },
  ["catppuccin/nvim"] = {
    transparent_background = true,
    term_colors = true,
    integrations = {
      telescope = { enabled = true },
      neotree = { enabled = true },
      indent_blankline = { enabled = true },
    },
  },
}

-- Themes selectable off Omarchy. An entry with `plugin` installs it; the rest
-- are the self-contained colorschemes in colors/, which need no plugin at all.
-- Every NVIM_COLORSCHEME in ~/set-theme/set-theme must have an entry here.
--
-- A `plugin` may carry its own opts. Unlike `tweaks` those are theme-specific,
-- so they stay scoped to this table and never reach an Omarchy-supplied spec.
local local_themes = {
  ["rose-pine"] = { plugin = { "rose-pine/neovim", name = "rose-pine" } },
  ["rose-pine-moon"] = { plugin = { "rose-pine/neovim", name = "rose-pine" } },
  ["tokyonight-night"] = { plugin = { "folke/tokyonight.nvim" } },
  ["tokyonight-storm"] = { plugin = { "folke/tokyonight.nvim" } },
  ["catppuccin"] = { plugin = { "catppuccin/nvim", name = "catppuccin" } },
  ["kanagawa"] = { plugin = { "rebelot/kanagawa.nvim" } },
  ["nordfox"] = { plugin = { "EdenEast/nightfox.nvim" } },
  ["bamboo"] = { plugin = { "ribru17/bamboo.nvim" } },
  ["retro-82"] = { plugin = { "OldJobobo/retro-82.nvim" } },
  -- set-theme's "hinterlands". The Omarchy theme repo ships a neovim.lua that
  -- passes base16 keys (base00..base0F); aether.nvim v3 takes semantic keys
  -- instead, so the repo's role assignments are translated below — each comment
  -- names the base16 slot it came from. Values not covered by base16 come from
  -- the theme's colors.toml. On Omarchy this is unused: Omarchy generates its
  -- own aether spec, with the palette already in semantic keys.
  ["aether"] = {
    plugin = {
      "bjarneo/aether.nvim",
      name = "aether",
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
          accent = "#686868",
          cursor = "#ffffff",
          foreground = "#ffffff",
          background = "#222222",
          selection_foreground = "#ffffff",
          selection_background = "#686868",

          bg = "#222222", -- base00 default background
          dark_bg = "#1a1a1a",
          darker_bg = "#141414",
          lighter_bg = "#525252", -- base01 lighter background (status bars)
          selection = "#686868", -- colors.toml selection_background
          muted = "#525252", -- base03 comments, invisibles
          dark_fg = "#b9b9b9", -- base04 dark foreground
          fg = "#ffffff", -- base05 default foreground
          light_fg = "#ffffff", -- base06 light foreground
          bright_fg = "#ffffff",

          red = "#7c7c7c", -- base08 variables, errors
          orange = "#7c7c7c", -- base09 integers, constants
          yellow = "#a0a0a0", -- base0A classes, types
          green = "#8b8b8b", -- base0B strings
          cyan = "#868686", -- base0C support, regex
          blue = "#686868", -- base0D functions, keywords
          purple = "#747474", -- base0E keywords, storage
          brown = "#a0a0a0", -- base0F deprecated

          bright_red = "#7c7c7c",
          bright_yellow = "#a0a0a0",
          bright_green = "#8b8b8b",
          bright_cyan = "#868686",
          bright_blue = "#686868",
          bright_purple = "#747474",
        },
      },
    },
  },
  ["andromeda"] = {},
  ["drive"] = {},
  ["matte-black"] = {},
  ["tomorrow-night-burns"] = {},
  ["vanta-black"] = {},
  ["ristretto"] = {},
}

local function local_spec()
  local theme = local_themes[FALLBACK]
    or error("theme.lua: unknown FALLBACK colorscheme " .. FALLBACK)
  local spec = { { "LazyVim/LazyVim", opts = { colorscheme = FALLBACK } } }

  if theme.plugin then
    theme.plugin.priority = 1000
    table.insert(spec, theme.plugin)
  end

  return spec
end

local function apply_tweaks(spec)
  for _, plugin in ipairs(spec) do
    local opts = tweaks[plugin[1]]
    if opts then
      plugin.opts = vim.tbl_deep_extend("force", opts, plugin.opts or {})
    end
  end

  return spec
end

local function omarchy_theme()
  for _, path in ipairs(OMARCHY_THEMES) do
    path = vim.fn.expand(path)
    if vim.uv.fs_stat(path) then
      return path
    end
  end
end

local omarchy = omarchy_theme()
if omarchy then
  return apply_tweaks(dofile(omarchy))
end

return apply_tweaks(local_spec())
