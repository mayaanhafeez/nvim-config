return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- installed via `brew install llvm`, skip Mason
        clangd = {
          mason = false,
          cmd = { "/opt/homebrew/opt/llvm/bin/clangd" },
        },

        -- installed via `cargo install asm-lsp`, skip Mason
        asm_lsp = {
          mason = false,
          filetypes = { "asm", "s", "S" },
        },

        pyright = {},

        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                },
              },
            },
          },
        },

        -- installed via `go install golang.org/x/tools/gopls@latest`, skip Mason
        gopls = {
          mason = false,
        },

        vtsls = {},
      },
    },
  },
}
