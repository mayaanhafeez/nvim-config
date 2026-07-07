return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gclog", "Gwrite", "Gread" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
    },
  },
}
