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

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- The focused window goes transparent; inactive windows keep the
    -- colorscheme's own background so they read as dimmed. Captured before
    -- Normal is cleared, so it follows whatever theme set-theme switched to.
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    local nc = vim.api.nvim_get_hl(0, { name = "NormalNC", link = false })
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { fg = nc.fg or normal.fg, bg = nc.bg or normal.bg })
  end,
})

-- no statusline (lualine is disabled); show "-- INSERT --" etc. in the command line
vim.opt.showmode = true
vim.opt.laststatus = 1

-- native number column: current line number sits left, relative numbers right-aligned
vim.opt.statuscolumn = ""

-- vertical guide line at column 80
vim.opt.colorcolumn = "80"
