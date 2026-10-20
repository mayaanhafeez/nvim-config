local function inline_images()
  if vim.tbl_contains(vim.v.argv, "--headless") or vim.fn.executable("magick") == 0 then
    return false
  end
  return vim.env.TERM_PROGRAM == "ghostty"
    or vim.env.GHOSTTY_RESOURCES_DIR ~= nil -- Survives tmux's TERM/TERM_PROGRAM overrides.
    or vim.env.TERM == "xterm-ghostty"
    or vim.env.TERM == "xterm-kitty"
    or vim.env.KITTY_WINDOW_ID ~= nil
end

return {
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false, -- Must intercept .ipynb reads before Neovim reads the JSON.
    opts = { style = "percent" },
  },
  {
    "benlubas/molten-nvim",
    lazy = false, -- Remote commands must also be available to NotebookNavigator.
    build = ":UpdateRemotePlugins",
    dependencies = {
      {
        "3rd/image.nvim",
        build = false,
        config = function(_, opts)
          if inline_images() then
            require("image").setup(opts)
          end
        end,
        opts = {
          backend = "kitty",
          processor = "magick_cli",
          max_height_window_percentage = 40,
          window_overlap_clear_enabled = true,
          tmux_show_only_in_active_window = true,
          hijack_file_patterns = {},
          integrations = {
            markdown = { enabled = false },
            asciidoc = { enabled = false },
            neorg = { enabled = false },
            rst = { enabled = false },
            typst = { enabled = false },
          },
        },
      },
    },
    init = function()
      vim.g.molten_image_provider = inline_images() and "image.nvim" or "none"
      vim.g.molten_auto_open_output = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_tick_rate = 200
    end,
    config = function()
      require("config.notebooks").setup()
    end,
  },
  {
    "GCBallesteros/NotebookNavigator.nvim",
    ft = "python",
    dependencies = { "benlubas/molten-nvim" },
    opts = { repl_provider = "molten", syntax_highlight = true },
  },
  {
    "folke/which-key.nvim",
    opts = { spec = { { "<leader>j", group = "notebook", icon = " " } } },
  },
}
