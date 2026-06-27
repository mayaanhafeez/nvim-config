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
  {
    "nosduco/remote-sshfs.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("remote-sshfs").setup({})
      require("telescope").load_extension("remote-sshfs")
      local api = require("remote-sshfs.api")
      vim.keymap.set("n", "<leader>rc", api.connect, { desc = "Remote SSH connect" })
      vim.keymap.set("n", "<leader>rd", api.disconnect, { desc = "Remote SSH disconnect" })
      vim.keymap.set("n", "<leader>re", api.edit, { desc = "Remote SSH edit config" })
    end,
  },
}
