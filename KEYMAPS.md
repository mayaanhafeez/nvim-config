# Keymaps

## Custom (lua/config/keymaps.lua)

| Key       | Mode   | Action                                  |
|-----------|--------|-----------------------------------------|
| `<K>`     | visual | Move selection up                       |
| `<J>`     | visual | Move selection down                     |
| `s`       | n/x/o  | Default vim substitute (not flash.nvim) |
| `-`           | normal | Open netrw in current file's directory  |
| `<leader>pv`  | normal | Open netrw (file explorer)              |

## Harpoon (lua/plugins/harpoon.lua)

| Key          | Mode   | Action                        |
|--------------|--------|-------------------------------|
| `<leader>a`  | normal | Add file to harpoon list      |
| `<leader>A`  | normal | Prepend file to harpoon list  |
| `<C-e>`      | normal | Toggle harpoon quick menu     |
| `<leader>1`  | normal | Jump to harpoon file 1        |
| `<leader>2`  | normal | Jump to harpoon file 2        |
| `<leader>3`  | normal | Jump to harpoon file 3        |
| `<leader>4`  | normal | Jump to harpoon file 4        |

## Projects (lua/plugins/projects.lua)

| Key          | Mode   | Action              |
|--------------|--------|---------------------|
| `<leader>fp` | normal | Telescope projects  |

## LazyVim Defaults (not overridden)

These come from LazyVim — run `:Lazy` and check each plugin, or see full list at:
https://www.lazyvim.org/keymaps

| Key           | Action                              |
|---------------|-------------------------------------|
| `<leader>e`   | Toggle file explorer (snacks)       |
| `<leader>ff`  | Find files (telescope)              |
| `<leader>fg`  | Live grep                           |
| `<leader>fb`  | Buffers                             |
| `<leader>/`   | Search in buffer                    |
| `<leader>gg`  | Open lazygit                        |
| `<leader>bd`  | Delete buffer                       |
| `gcc`         | Toggle line comment                 |
| `gd`          | Go to definition (LSP)              |
| `gr`          | References (LSP)                    |
| `K`           | Hover docs (LSP)                    |
| `]d` / `[d`   | Next/prev diagnostic                |
| `<leader>ca`  | Code action                         |
| `<leader>cr`  | Rename symbol                       |

## Help Navigation

| Key     | Action                        |
|---------|-------------------------------|
| `<C-]>` | Follow tag/link under cursor  |
| `<C-t>` | Jump back                     |
