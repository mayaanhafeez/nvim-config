vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "ristretto"
vim.o.termguicolors = true

local c = {
  bg = "#2c2525", surface = "#3d2f2a", fg = "#e6d9db", muted = "#72696a",
  red = "#fd6883", yellow = "#f9cc6c", orange = "#fb9a77", green = "#adda78",
  cyan = "#85dacc", blue = "#f38d70", purple = "#a8a9eb", selection = "#403e41",
}
local hl = vim.api.nvim_set_hl
hl(0, "Normal", { fg = c.fg, bg = c.bg })
hl(0, "NormalFloat", { fg = c.fg, bg = c.surface })
hl(0, "CursorLine", { bg = c.surface })
hl(0, "LineNr", { fg = c.muted })
hl(0, "CursorLineNr", { fg = c.blue, bold = true })
hl(0, "Visual", { bg = c.selection })
hl(0, "StatusLine", { fg = c.fg, bg = c.surface })
hl(0, "Pmenu", { fg = c.fg, bg = c.surface })
hl(0, "PmenuSel", { fg = c.bg, bg = c.blue })
hl(0, "WinSeparator", { fg = c.muted })
hl(0, "Comment", { fg = c.muted, italic = true })
hl(0, "String", { fg = c.green })
hl(0, "Number", { fg = c.orange })
hl(0, "Boolean", { fg = c.orange })
hl(0, "Constant", { fg = c.orange })
hl(0, "Function", { fg = c.blue })
hl(0, "Keyword", { fg = c.red })
hl(0, "Statement", { fg = c.red })
hl(0, "Type", { fg = c.cyan })
hl(0, "Special", { fg = c.purple })
hl(0, "Identifier", { fg = c.fg })
hl(0, "Operator", { fg = c.purple })
hl(0, "DiagnosticError", { fg = c.red })
hl(0, "DiagnosticWarn", { fg = c.yellow })
hl(0, "DiagnosticInfo", { fg = c.cyan })
hl(0, "DiagnosticHint", { fg = c.green })
