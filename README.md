# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Jupyter notebooks

Run `bash ~/.config/nvim/scripts/setup-notebooks.sh` once (requires `uv`), install
`imagemagick` with Homebrew for inline plots, then run `:Lazy sync` and restart Neovim.
Python tooling lives in `~/.local/share/nvim/jupyter`, not in project environments.

Open an existing `.ipynb`, or use `:NewNotebook path/name.ipynb`. Notebooks appear as
Python with `# %%` cell markers; markdown cells appear as `# %% [markdown]` followed
by comments. Normal Python completion/diagnostics still work. `:w` saves a real
notebook, including Molten outputs when a kernel is attached. Jupytext uses a
sibling `.py` file during editing; do not simultaneously edit a same-named script.

| Keys (Space is leader) | Action |
| --- | --- |
| `<leader>ji` | Choose/start a kernel (`Python (Neovim)` is included) |
| `<leader>jr` | Run current cell, or visual selection |
| `<leader>jn` | Run cell and move to the next |
| `<leader>ja` | Run all code cells separately (skips markdown/raw cells) |
| `]h` / `[h` | Next / previous cell |
| `<leader>jc` | Add a cell below |
| `<leader>jo` / `<leader>jh` | Open / hide output window |
| `<leader>jx` / `<leader>jR` / `<leader>jq` | Interrupt / restart / stop kernel |
| `<leader>jl` | Reload saved notebook outputs |
| `<leader>jp` | Open a plot in the system image viewer |

No kernel starts and no code executes merely by opening a notebook. Starting a
kernel imports saved outputs; it does not restore Python variables, so re-run
cells to rebuild runtime state. Wait for execution to finish before saving output.
For reliable output export, run whole cells rather than overlapping selections.
Molten's output matching is experimental; keep notebooks in version control.
Use one kernel per notebook buffer for automatic output import/export.

Inline plots use image.nvim's Kitty-protocol backend in Ghostty/Kitty. tmux needs
`allow-passthrough on`, `visual-activity off`, and `focus-events on`. Ghostty's
rendering may have quirks; `<leader>jp` is the fallback. Interactive HTML/widgets
still need browser Jupyter. Use `%matplotlib inline` when plotting.

For a project's packages, register its virtual environment as a kernel, then
choose it with `<leader>ji` (the editor's tooling environment stays separate):

```sh
uv pip install --python .venv/bin/python ipykernel
.venv/bin/python -m ipykernel install --user --name my-project --display-name 'Python (my-project)'
```
