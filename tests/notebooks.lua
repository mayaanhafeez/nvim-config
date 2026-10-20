-- Run from the config root: nvim --headless -u NONE -l tests/notebooks.lua
package.path = "./lua/?.lua;" .. package.path
local notebooks = require("config.notebooks")
local calls, moves = {}, 0
vim.fn.MoltenRunningKernels = function()
  return { "test" }
end
vim.fn.MoltenEvaluateRange = function(...)
  calls[#calls + 1] = { ... }
end
package.loaded["notebook-navigator"] = {
  move_cell = function()
    moves = moves + 1
  end,
}

local function buffer(lines, row)
  vim.cmd.enew({ bang = true })
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.api.nvim_win_set_cursor(0, { row or 1, 0 })
  calls = {}
end

buffer({
  "# ---",
  "# jupyter metadata",
  "# ---",
  "",
  "# %%",
  "",
  "x = 21",
  "",
  "# %% [markdown]",
  "# Heading",
  "# %% [raw]",
  "raw text",
  "# %%",
  "print(x * 2)",
})
local original = vim.api.nvim_buf_get_lines(0, 0, -1, false)
notebooks.run(true, false)
assert(vim.deep_equal(calls, { { 7, 7, 1, 7 }, { 14, 14, 1, 13 } }), vim.inspect(calls))
assert(vim.deep_equal(original, vim.api.nvim_buf_get_lines(0, 0, -1, false)), "Running must not change source")

for _, row in ipairs({ 5, 6, 7, 8 }) do
  calls = {}
  vim.api.nvim_win_set_cursor(0, { row, 0 })
  notebooks.run(false, false)
  assert(vim.deep_equal(calls, { { 7, 7, 1, 7 } }), "Cell boundary failed at " .. row)
end
calls = {}
vim.api.nvim_win_set_cursor(0, { 9, 0 })
notebooks.run(false, true)
assert(#calls == 0 and moves == 1, "Markdown should be skipped")

buffer({ "print('no marker')" })
notebooks.run(false, false)
assert(vim.deep_equal(calls, { { 1, 1, 1, 19 } }), vim.inspect(calls))
buffer({ "# %%", "# Only comments", "", "# %%", "" })
notebooks.run(true, false)
assert(#calls == 0, "Empty/comment-only cells should be skipped")

-- NewNotebook creates valid JSON and refuses to replace existing files.
local dir = vim.fn.tempname()
vim.fn.mkdir(dir, "p")
local path = dir .. "/new notebook.ipynb"
notebooks.new(path)
local contents = table.concat(vim.fn.readfile(path), "\n")
local nb = vim.json.decode(contents)
assert(nb.nbformat == 4 and nb.cells[1].cell_type == "code")
assert(nb.metadata.kernelspec.name == "nvim-python3")
local notify = vim.notify
local refused = false
vim.notify = function(message)
  refused = message:find("Refusing to overwrite", 1, true) ~= nil
end
notebooks.new(path)
vim.notify = notify
assert(refused and contents == table.concat(vim.fn.readfile(path), "\n"))
vim.cmd.enew({ bang = true })
vim.fn.delete(path)
vim.fn.delete(dir, "d")
print("Notebook tests passed")
