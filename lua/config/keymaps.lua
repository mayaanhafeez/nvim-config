-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Restore vim default 's' (substitute character) instead of flash.nvim
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set({ "n", "x", "o" }, "s", "s")

vim.keymap.set("n", "-", function()
  vim.cmd("Ex " .. vim.fn.expand("%:p:h"))
end, { desc = "Open netrw in current file's directory" })

vim.keymap.set("n", "<leader>pv", function()
  vim.cmd("Ex " .. vim.fn.expand("%:p:h"))
end, { desc = "Open netrw (file explorer)" })
