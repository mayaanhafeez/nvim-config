return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = { auto_show = false },
        ghost_text = { enabled = true },
      },
      keymap = {
        preset = "default",
        ["<CR>"] = { "fallback" },
        ["<Tab>"] = { "select_and_accept", "fallback" },
      },
    },
  },
}
