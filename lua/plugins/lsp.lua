return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- no inline type/parameter hints by default; <leader>uh toggles them
      inlay_hints = { enabled = false },
      servers = {
        -- installed via `brew install llvm@22`, skip Mason
        clangd = {
          mason = false,
          cmd = { "/opt/homebrew/opt/llvm@22/bin/clangd" },
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

        -- installed via Mason, but neither lspconfig nor mason-lspconfig know about it
        kmp_lsp = {
          mason = false,
          cmd = { vim.fn.stdpath("data") .. "/mason/bin/kmp-lsp" },
          filetypes = { "kotlin", "java" },
          root_markers = { "settings.gradle.kts", "settings.gradle", ".git" },
        },
      },
    },
  },
}
