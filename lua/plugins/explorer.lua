-- The Snacks explorer is off entirely (netrw and :Sex cover it); its keys from
-- LazyVim's default snacks_explorer extra are dropped too.
local explorer_keys = { ["<leader>e"] = true, ["<leader>E"] = true, ["<leader>fe"] = true, ["<leader>fE"] = true }

return {
  {
    "folke/snacks.nvim",
    keys = function(_, keys)
      return vim.tbl_filter(function(key)
        return not explorer_keys[type(key) == "table" and key[1] or key]
      end, keys)
    end,
    opts = {
      explorer = {
        enabled = false,
        replace_netrw = false,
      },
      picker = {
        sources = {
          -- show dotfiles and gitignored files (.env is usually both), minus
          -- the gitignored folders that would bury everything else
          files = {
            hidden = true,
            ignored = true,
            exclude = {
              ".git",
              "node_modules",
              ".venv",
              "venv",
              "__pycache__",
              "target",
              "dist",
              "build",
              ".next",
              ".cache",
              ".DS_Store",
            },
          },
        },
      },
    },
  },
}
