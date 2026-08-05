-- Colorscheme selection, Omarchy-style.
--
-- Omarchy keeps the active system theme's lazy spec at
-- ~/.local/state/omarchy/current/theme/neovim.lua and rewrites it on every
-- `omarchy theme set`. Loading that file is exactly what Omarchy's own
-- lua/plugins/theme.lua symlink does; a plain file is used here instead so this
-- config survives being pushed to git and pulled onto a machine (macOS) that
-- has no Omarchy state to point at.
--
-- On Omarchy: nvim follows the system theme, nothing to configure.
-- Elsewhere: FALLBACK below picks the theme.

local OMARCHY_THEME = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")

-- Only consulted when Omarchy is absent. Must be a key of `local_themes`.
local FALLBACK = "rose-pine"

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
local local_themes = {
  ["rose-pine"] = { plugin = { "rose-pine/neovim", name = "rose-pine" } },
  ["tokyonight-night"] = { plugin = { "folke/tokyonight.nvim" } },
  ["catppuccin"] = { plugin = { "catppuccin/nvim", name = "catppuccin" } },
  ["andromeda"] = {},
  ["matte-black"] = {},
  ["tomorrow-night-burns"] = {},
  ["vanta-black"] = {},
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

if vim.uv.fs_stat(OMARCHY_THEME) then
  return apply_tweaks(dofile(OMARCHY_THEME))
end

return apply_tweaks(local_spec())
