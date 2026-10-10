-- Free up <leader>s and <leader>x for the keymaps in config/keymaps.lua by
-- dropping LazyVim's search (<leader>s*) and diagnostics (<leader>x*) submaps.
local function drop_leader_menus(_, keys)
  return vim.tbl_filter(function(key)
    local lhs = type(key) == "table" and key[1] or key
    return not (type(lhs) == "string" and #lhs > #"<leader>s" and lhs:match("^<leader>[sx]"))
  end, keys)
end

return {
  { "folke/snacks.nvim", keys = drop_leader_menus },
  { "folke/trouble.nvim", keys = drop_leader_menus },
  { "folke/todo-comments.nvim", keys = drop_leader_menus },
  { "MagicDuck/grug-far.nvim", keys = drop_leader_menus },
}
