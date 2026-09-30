-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = false
vim.opt.scrolloff = 8
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  signs = true,
  update_in_insert = false,
})

vim.opt.list = false

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  end,
})

-- no statusline (lualine is disabled); show "-- INSERT --" etc. in the command line
vim.opt.showmode = true
vim.opt.laststatus = 1

-- native number column: current line number sits left, relative numbers right-aligned
vim.opt.statuscolumn = ""

-- vertical guide line at column 80
vim.opt.colorcolumn = "80"
