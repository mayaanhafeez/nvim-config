-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = false
vim.opt.scrolloff = 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.guicursor = "" -- block cursor in every mode
vim.opt.updatetime = 50
vim.opt.isfname:append("@-@") -- let gf follow paths containing @
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  signs = true,
  update_in_insert = false,
})

vim.opt.list = false

-- hide netrw's help/sort banner at the top of the listing
vim.g.netrw_banner = 0

-- Fallback for themes whose CursorLine has no background: how far inactive
-- windows move from the theme background toward its text colour
local INACTIVE_TINT = 0.08

-- mix two 0xRRGGBB colours, t of the way from a to b
local function blend(a, b, t)
  local out = 0
  for shift = 16, 0, -8 do
    local ca, cb = bit.band(bit.rshift(a, shift), 0xff), bit.band(bit.rshift(b, shift), 0xff)
    out = out + bit.lshift(math.floor(ca + (cb - ca) * t + 0.5), shift)
  end
  return out
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- The focused window goes transparent; inactive windows take the theme's
    -- current-line colour, so they stand out whatever the terminal's opacity.
    -- Read before Normal is cleared, so it follows set-theme.
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    local bg = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false }).bg
    if not bg and normal.bg then
      local fg = normal.fg or (vim.o.background == "light" and 0x000000 or 0xffffff)
      bg = blend(normal.bg, fg, INACTIVE_TINT)
    end
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { fg = normal.fg, bg = bg })
  end,
})

-- no statusline (lualine is disabled); show "-- INSERT --" etc. in the command line
vim.opt.showmode = true
vim.opt.laststatus = 1

-- native number column: current line number sits left, relative numbers right-aligned
vim.opt.statuscolumn = ""

-- vertical guide line at column 80
vim.opt.colorcolumn = "80"
