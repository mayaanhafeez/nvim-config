-- Uses the installed plugins and kernel:
-- nvim --headless '+luafile tests/notebooks-integration.lua'
local dir = vim.fn.tempname()
vim.notify = function(message)
  print(message)
end
vim.fn.mkdir(dir, "p")
local path = dir .. "/" .. (vim.env.NVIM_NOTEBOOK_TEST_NAME or "notebook.ipynb")
local function read()
  return vim.json.decode(table.concat(vim.fn.readfile(path), "\n"))
end
local function text(value)
  return type(value) == "table" and table.concat(value) or value
end

local ok, err = xpcall(function()
  require("config.notebooks").new(path)
  assert(vim.bo.filetype == "python", "Notebook was not converted to Python")
  assert(#vim.fn.MoltenRunningKernels(true) == 0, "Opening must not start a kernel")
  assert(vim.fn.maparg("<leader>jr", "n") ~= "", "Missing notebook keymaps")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "# %%",
    "x = 21",
    "# %% [markdown]",
    "# Test markdown survives",
    "# %%",
    "print(x * 2)",
    "# %%",
    "%matplotlib inline",
    "import matplotlib.pyplot as plt",
    "plt.plot([1, 2, 3])",
    "plt.show()",
  })
  vim.cmd.write()
  vim.cmd("MoltenInit nvim-python3")
  -- Let scheduled saved-output import finish before executing.
  vim.wait(500, function()
    return false
  end, 50)
  assert(#vim.fn.MoltenRunningKernels(true) == 1, "Kernel failed to start")
  require("config.notebooks").run(true, false)
  local finished = vim.wait(30000, function()
    vim.cmd("silent write")
    local nb = read()
    local output = nb.cells[3].outputs[1]
    local plot = nb.cells[4].outputs[1]
    return output
      and text(output.text or (output.data or {})["text/plain"]) == "42\n"
      and plot
      and plot.data
      and plot.data["image/png"] ~= nil
  end, 500)
  assert(finished, "Expected numeric output and PNG plot were not saved")
  assert(read().cells[2].cell_type == "markdown", "Markdown was lost")
  vim.cmd.MoltenDeinit()
  vim.cmd("edit!")
  vim.cmd("MoltenInit nvim-python3")
  vim.wait(500, function()
    return false
  end, 50)
  vim.cmd.write()
  local output = read().cells[3].outputs[1]
  assert(
    text(output.text or (output.data or {})["text/plain"]) == "42\n",
    "Saved outputs did not survive reopen/import"
  )
  print("Notebook integration passed: cells, markdown, Python execution, PNG output, save and reload")
end, debug.traceback)

if vim.fn.exists("*MoltenRunningKernels") == 1 and #vim.fn.MoltenRunningKernels(true) > 0 then
  vim.cmd.MoltenDeinit()
end
vim.cmd.enew({ bang = true })
vim.fn.delete(path)
local script_path = path:gsub("%.ipynb$", ".py")
vim.fn.delete(script_path)
vim.fn.delete(dir, "d")
if not ok then
  io.stderr:write(err .. "\n")
  vim.cmd.cquit()
else
  vim.cmd.qa({ bang = true })
end
