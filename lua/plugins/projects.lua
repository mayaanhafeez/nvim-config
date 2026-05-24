-- ~/.config/nvim/lua/plugins/projects.lua
return {
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "plenary.nvim" },
    config = function()
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    },
  },
}
