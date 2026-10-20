local M = {}

-- Send each percent-format cell separately, so .ipynb outputs round-trip correctly.
-- NotebookNavigator's run_all_cells sends the entire file as one cell instead.
local function code_cells()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local cells, first, marker, markdown = {}, 1, 1, false
  local function add(last)
    local start, boundary = first, last
    while start <= last and lines[start]:match("^%s*$") do
      start = start + 1
    end
    while last >= start and lines[last]:match("^%s*$") do
      last = last - 1
    end
    if not markdown and start <= last then
      -- Ignore Jupytext's commented metadata header and empty/comment-only cells.
      for i = start, last do
        if not lines[i]:match("^%s*#") and not lines[i]:match("^%s*$") then
          cells[#cells + 1] =
            { marker = marker, boundary = boundary, first = start, last = last, end_col = #lines[last] + 1 }
          break
        end
      end
    end
  end
  for i, line in ipairs(lines) do
    if line:match("^# %%%%") then
      add(i - 1)
      first, marker = i + 1, i
      markdown = line:find("[markdown]", 1, true) ~= nil or line:find("[raw]", 1, true) ~= nil
    end
  end
  add(#lines)
  return cells
end

function M.run(all, move)
  if #vim.fn.MoltenRunningKernels(true) == 0 then
    vim.notify("Choose a kernel with <leader>ji first, then run the cell.", vim.log.levels.INFO)
    vim.cmd.MoltenInit()
    return
  end
  local row = vim.api.nvim_win_get_cursor(0)[1]
  for _, cell in ipairs(code_cells()) do
    -- A cursor on the # %% marker belongs to the following cell.
    if all or (row >= cell.marker and row <= cell.boundary) then
      vim.fn.MoltenEvaluateRange(cell.first, cell.last, 1, cell.end_col)
      if not all then
        break
      end
    end
  end
  if move then
    require("notebook-navigator").move_cell("d")
  end
end

function M.new(path)
  path = vim.fn.fnamemodify(vim.fn.expand(path), ":p")
  if not path:match("%.ipynb$") then
    path = path .. ".ipynb"
  end
  if vim.uv.fs_stat(path) then
    vim.notify("Refusing to overwrite " .. path, vim.log.levels.ERROR)
    return
  end
  local notebook = {
    nbformat = 4,
    nbformat_minor = 5,
    metadata = {
      kernelspec = { display_name = "Python (Neovim)", language = "python", name = "nvim-python3" },
      language_info = { name = "python", file_extension = ".py" },
    },
    cells = {
      {
        id = "first-cell",
        cell_type = "code",
        metadata = vim.empty_dict(),
        source = { "print('Hello from Neovim!')" },
        execution_count = vim.NIL,
        outputs = {},
      },
    },
  }
  local fd, err = vim.uv.fs_open(path, "wx", 420)
  if not fd then
    vim.notify(tostring(err), vim.log.levels.ERROR)
    return
  end
  local written, write_err = vim.uv.fs_write(fd, vim.json.encode(notebook) .. "\n")
  vim.uv.fs_close(fd)
  if not written then
    vim.notify(tostring(write_err), vim.log.levels.ERROR)
    return
  end
  vim.cmd.edit(vim.fn.fnameescape(path))
end

local function notebook_output(command)
  local kernels = vim.fn.MoltenRunningKernels(true)
  if #kernels ~= 1 then
    vim.notify("Notebook output import/export needs exactly one kernel in this buffer.", vim.log.levels.WARN)
    return
  end
  local path = vim.fn.expand("%:p:r") .. ".ipynb"
  -- Supplying the kernel avoids Molten rebuilding an unescaped command internally.
  vim.cmd(command .. " " .. vim.fn.fnameescape(path) .. " " .. vim.fn.fnameescape(kernels[1]))
end

function M.setup()
  local group = vim.api.nvim_create_augroup("notebooks", { clear = true })
  vim.api.nvim_create_user_command("NewNotebook", function(opts)
    M.new(opts.args)
  end, { nargs = 1, complete = "file", desc = "Create and open a Python Jupyter notebook" })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "python",
    callback = function(event)
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, silent = true, desc = desc })
      end
      map("n", "<leader>ji", "<cmd>MoltenInit<cr>", "Choose/start kernel")
      map("n", "<leader>jr", function()
        M.run(false, false)
      end, "Run cell")
      map("n", "<leader>jn", function()
        M.run(false, true)
      end, "Run cell and move down")
      map("n", "<leader>ja", function()
        M.run(true, false)
      end, "Run all code cells")
      map("x", "<leader>jr", ":<C-u>MoltenEvaluateVisual<cr>gv", "Run selection")
      map("n", "]h", function()
        require("notebook-navigator").move_cell("d")
      end, "Next notebook cell")
      map("n", "[h", function()
        require("notebook-navigator").move_cell("u")
      end, "Previous notebook cell")
      map("n", "<leader>jc", function()
        require("notebook-navigator").add_cell_below()
      end, "Add cell below")
      map("n", "<leader>jo", "<cmd>noautocmd MoltenEnterOutput<cr>", "Open output window")
      map("n", "<leader>jh", "<cmd>MoltenHideOutput<cr>", "Hide output window")
      map("n", "<leader>jx", "<cmd>MoltenInterrupt<cr>", "Interrupt kernel")
      map("n", "<leader>jR", "<cmd>MoltenRestart<cr>", "Restart kernel")
      map("n", "<leader>jq", "<cmd>MoltenDeinit<cr>", "Stop kernel")
      map("n", "<leader>jl", function()
        notebook_output("MoltenImportOutput")
      end, "Load saved notebook outputs")
      map("n", "<leader>jp", "<cmd>MoltenImagePopup<cr>", "Open plot in external viewer")
    end,
  })

  -- Import saved output only after explicitly starting a kernel; never execute on open.
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "MoltenInitPost",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      if not vim.api.nvim_buf_get_name(buf):match("%.ipynb$") then
        return
      end
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_call(buf, function()
            if #vim.fn.MoltenRunningKernels(true) == 1 then
              notebook_output("MoltenImportOutput")
            end
          end)
        end
      end)
    end,
  })
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = "*.ipynb",
    callback = function()
      if vim.fn.exists("*MoltenRunningKernels") == 1 and #vim.fn.MoltenRunningKernels(true) > 0 then
        notebook_output("MoltenExportOutput!")
      end
    end,
  })
end

return M
