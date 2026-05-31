return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "clangd", "pyright" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {},
        pyright = {},
      },
    },
  },
}
