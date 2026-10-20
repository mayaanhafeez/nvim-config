#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
venv="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/jupyter"

command -v uv >/dev/null || { echo 'Install uv first: brew install uv' >&2; exit 1; }
if [[ ! -x "$venv/bin/python" ]]; then
  uv venv --python 3.13 "$venv"
fi
uv pip install --python "$venv/bin/python" -r "$root/scripts/notebook-requirements.txt"
"$venv/bin/python" -m ipykernel install --user --name nvim-python3 --display-name 'Python (Neovim)'

if ! command -v magick >/dev/null; then
  echo 'For inline plots, install ImageMagick: brew install imagemagick'
fi
echo 'Notebook dependencies ready. In Neovim run :Lazy sync, then restart.'
