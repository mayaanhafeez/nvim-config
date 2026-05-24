return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        auto_open = false,
        replace_netrw = false,
      },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },
}
