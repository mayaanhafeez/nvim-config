-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Restore vim default 's' (substitute character) instead of flash.nvim
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv", { desc = "Move block up" })
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv", { desc = "Move block down" })
vim.keymap.set({ "n", "x", "o" }, "s", "s")
