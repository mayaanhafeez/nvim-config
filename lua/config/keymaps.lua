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

-- <leader>s and <leader>x replace LazyVim's search and diagnostics menus (their
-- plugin keys are dropped in plugins/leader-menus.lua). LazyVim also adds
-- buffer-local <leader>ss/<leader>sS when an LSP attaches; clear those so the
-- bare keys don't wait out timeoutlen for a second keystroke.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(e)
    vim.schedule(function()
      for _, map in ipairs(vim.api.nvim_buf_get_keymap(e.buf, "n")) do
        local lhs = map.lhs:gsub("^<Space>", " ")
        if #lhs > 2 and (lhs:sub(1, 2) == " s" or lhs:sub(1, 2) == " x") then
          pcall(vim.api.nvim_buf_del_keymap, e.buf, "n", map.lhs)
        end
      end
    end)
  end,
})

-- these two come from LazyVim's own keymaps rather than a plugin spec
pcall(vim.keymap.del, "n", "<leader>xl")
pcall(vim.keymap.del, "n", "<leader>xq")

-- rename the word under the cursor across the file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })
