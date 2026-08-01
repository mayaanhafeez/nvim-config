vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "vanta-black"
vim.o.termguicolors = true

-- Colors from the vanta-black palette (Omarchy colors.toml key format).
-- Comments name the palette key each role was taken from.
local c = {
  bg          = "#000000", -- background
  bg1         = "#1a1a1a", -- lighter_background / selection
  bg2         = "#090909", -- dark_background
  fg          = "#ffffff", -- foreground — variables
  comment     = "#505050", -- dark_foreground
  keyword     = "#a4a4a4", -- red
  fn          = "#8d8d8d", -- blue / accent — functions
  string      = "#b6b6b6", -- green
  type        = "#cecece", -- yellow — classes, types
  const       = "#b9b9b9", -- orange — constants, numbers
  white       = "#ffffff", -- bright_foreground
  cursor      = "#ffffff", -- foreground
  visual      = "#1a1a1a", -- selection
  diff_add    = "#0f0f0f",
  diff_change = "#121212",
  diff_delete = "#141414",
  diff_text   = "#1f1f1f",
  vt_error    = "#141414",
  vt_warn     = "#121212",
  vt_info     = "#101010",
  vt_hint     = "#0d0d0d",
}
local hl = vim.api.nvim_set_hl

-- Base
hl(0, "Normal", { fg = c.fg, bg = c.bg })
hl(0, "NormalFloat", { fg = c.fg, bg = c.bg1 })
hl(0, "NormalNC", { fg = c.fg, bg = c.bg })
hl(0, "EndOfBuffer", { fg = c.bg1 })

-- Cursor & line
hl(0, "Cursor", { fg = c.bg, bg = c.cursor })
hl(0, "CursorIM", { fg = c.bg, bg = c.cursor })
hl(0, "CursorLine", { bg = c.bg1 })
hl(0, "CursorColumn", { bg = c.bg1 })
hl(0, "CursorLineNr", { fg = c.fg, bold = true })
hl(0, "LineNr", { fg = c.comment })

-- Columns & folds
hl(0, "SignColumn", { fg = c.comment, bg = c.bg })
hl(0, "ColorColumn", { bg = c.bg1 })
hl(0, "FoldColumn", { fg = c.comment, bg = c.bg })
hl(0, "Folded", { fg = c.comment, bg = c.bg1 })

-- Selection & search
hl(0, "Visual", { bg = c.visual })
hl(0, "VisualNOS", { bg = c.visual })
hl(0, "Search", { fg = c.bg, bg = c.const })
hl(0, "IncSearch", { fg = c.bg, bg = c.string })
hl(0, "CurSearch", { fg = c.bg, bg = c.string })
hl(0, "Substitute", { fg = c.bg, bg = c.const })

-- Status & tab line
hl(0, "StatusLine", { fg = c.fg, bg = c.bg1 })
hl(0, "StatusLineNC", { fg = c.comment, bg = c.bg1 })
hl(0, "TabLine", { fg = c.comment, bg = c.bg })
hl(0, "TabLineFill", { bg = c.bg })
hl(0, "TabLineSel", { fg = c.fg, bg = c.bg2, bold = true })

-- Popup menu
hl(0, "Pmenu", { fg = c.fg, bg = c.bg1 })
hl(0, "PmenuSel", { fg = c.bg, bg = c.keyword })
hl(0, "PmenuSbar", { bg = c.bg1 })
hl(0, "PmenuThumb", { bg = c.comment })

-- Window borders
hl(0, "VertSplit", { fg = c.bg1 })
hl(0, "WinSeparator", { fg = c.bg1 })
hl(0, "FloatBorder", { fg = c.comment, bg = c.bg1 })

-- Misc UI
hl(0, "MatchParen", { fg = c.string, bold = true, underline = true })
hl(0, "NonText", { fg = c.bg1 })
hl(0, "SpecialKey", { fg = c.comment })
hl(0, "Whitespace", { fg = c.bg1 })
hl(0, "WildMenu", { fg = c.bg, bg = c.keyword })
hl(0, "Title", { fg = c.fn, bold = true })
hl(0, "Directory", { fg = c.fn })
hl(0, "Question", { fg = c.const })
hl(0, "MoreMsg", { fg = c.const })
hl(0, "ModeMsg", { fg = c.fg, bold = true })
hl(0, "MsgArea", { fg = c.fg, bg = c.bg })
hl(0, "MsgSeparator", { fg = c.comment, bg = c.bg1 })

-- Errors & warnings
hl(0, "Error", { fg = c.string, bold = true })
hl(0, "ErrorMsg", { fg = c.string })
hl(0, "WarningMsg", { fg = c.const })

-- Diff
hl(0, "DiffAdd", { fg = c.type, bg = c.diff_add })
hl(0, "DiffChange", { fg = c.fn, bg = c.diff_change })
hl(0, "DiffDelete", { fg = c.keyword, bg = c.diff_delete })
hl(0, "DiffText", { fg = c.string, bg = c.diff_text })

-- Spell
hl(0, "SpellBad", { undercurl = true, sp = c.string })
hl(0, "SpellCap", { undercurl = true, sp = c.type })
hl(0, "SpellRare", { undercurl = true, sp = c.fn })
hl(0, "SpellLocal", { undercurl = true, sp = c.type })

-- Diagnostics
hl(0, "DiagnosticError", { fg = c.string })
hl(0, "DiagnosticWarn", { fg = c.const })
hl(0, "DiagnosticInfo", { fg = c.type })
hl(0, "DiagnosticHint", { fg = c.comment })
hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.string })
hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = c.const })
hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = c.type })
hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = c.comment })
hl(0, "DiagnosticVirtualTextError", { fg = c.string, bg = c.vt_error })
hl(0, "DiagnosticVirtualTextWarn", { fg = c.const, bg = c.vt_warn })
hl(0, "DiagnosticVirtualTextInfo", { fg = c.type, bg = c.vt_info })
hl(0, "DiagnosticVirtualTextHint", { fg = c.comment, bg = c.vt_hint })

-- Syntax
hl(0, "Comment", { fg = c.comment, italic = true })
hl(0, "Constant", { fg = c.const })
hl(0, "String", { fg = c.string })
hl(0, "Character", { fg = c.string })
hl(0, "Number", { fg = c.const })
hl(0, "Boolean", { fg = c.const })
hl(0, "Float", { fg = c.const })
hl(0, "Identifier", { fg = c.fg })
hl(0, "Function", { fg = c.fn })
hl(0, "Statement", { fg = c.keyword })
hl(0, "Conditional", { fg = c.keyword })
hl(0, "Repeat", { fg = c.keyword })
hl(0, "Label", { fg = c.keyword })
hl(0, "Operator", { fg = c.fg })
hl(0, "Keyword", { fg = c.keyword })
hl(0, "Exception", { fg = c.keyword })
hl(0, "PreProc", { fg = c.keyword })
hl(0, "Include", { fg = c.keyword })
hl(0, "Define", { fg = c.keyword })
hl(0, "Macro", { fg = c.keyword })
hl(0, "PreCondit", { fg = c.keyword })
hl(0, "Type", { fg = c.type })
hl(0, "StorageClass", { fg = c.keyword })
hl(0, "Structure", { fg = c.type })
hl(0, "Typedef", { fg = c.type })
hl(0, "Special", { fg = c.const })
hl(0, "SpecialChar", { fg = c.const })
hl(0, "Tag", { fg = c.fn })
hl(0, "Delimiter", { fg = c.fg })
hl(0, "SpecialComment", { fg = c.comment })
hl(0, "Debug", { fg = c.string })
hl(0, "Underlined", { underline = true })
hl(0, "Ignore", { fg = c.comment })
hl(0, "Todo", { fg = c.bg, bg = c.const, bold = true })

-- Treesitter
hl(0, "@comment", { link = "Comment" })
hl(0, "@comment.documentation", { fg = c.comment, italic = true })
hl(0, "@keyword", { fg = c.keyword })
hl(0, "@keyword.function", { fg = c.keyword })
hl(0, "@keyword.return", { fg = c.keyword })
hl(0, "@keyword.import", { fg = c.keyword })
hl(0, "@keyword.operator", { fg = c.keyword })
hl(0, "@conditional", { fg = c.keyword })
hl(0, "@repeat", { fg = c.keyword })
hl(0, "@exception", { fg = c.keyword })
hl(0, "@include", { fg = c.keyword })
hl(0, "@function", { fg = c.fn })
hl(0, "@function.builtin", { fg = c.fn })
hl(0, "@function.call", { fg = c.fn })
hl(0, "@function.macro", { fg = c.fn })
hl(0, "@method", { fg = c.fn })
hl(0, "@method.call", { fg = c.fn })
hl(0, "@constructor", { fg = c.type })
hl(0, "@parameter", { fg = c.fg })
hl(0, "@variable", { fg = c.fg })
hl(0, "@variable.builtin", { fg = c.fg })
hl(0, "@field", { fg = c.fg })
hl(0, "@property", { fg = c.fg })
hl(0, "@namespace", { fg = c.keyword })
hl(0, "@module", { fg = c.keyword })
hl(0, "@string", { fg = c.string })
hl(0, "@string.escape", { fg = c.const })
hl(0, "@string.special", { fg = c.string })
hl(0, "@string.regex", { fg = c.string })
hl(0, "@number", { link = "Number" })
hl(0, "@float", { link = "Float" })
hl(0, "@boolean", { link = "Boolean" })
hl(0, "@constant", { fg = c.const })
hl(0, "@constant.builtin", { fg = c.const })
hl(0, "@constant.macro", { fg = c.const })
hl(0, "@operator", { fg = c.fg })
hl(0, "@punctuation.bracket", { fg = c.fg })
hl(0, "@punctuation.delimiter", { fg = c.fg })
hl(0, "@punctuation.special", { fg = c.const })
hl(0, "@type", { fg = c.type })
hl(0, "@type.builtin", { fg = c.type })
hl(0, "@type.definition", { fg = c.type })
hl(0, "@tag", { fg = c.fn })
hl(0, "@tag.attribute", { fg = c.type })
hl(0, "@tag.delimiter", { fg = c.fg })
hl(0, "@text", { fg = c.fg })
hl(0, "@text.literal", { fg = c.string })
hl(0, "@text.title", { fg = c.fn, bold = true })
hl(0, "@text.emphasis", { italic = true })
hl(0, "@text.strong", { bold = true })
hl(0, "@text.uri", { fg = c.string, underline = true })
hl(0, "@text.reference", { fg = c.fn })
hl(0, "@text.todo", { link = "Todo" })
hl(0, "@markup.heading", { fg = c.fn, bold = true })
hl(0, "@markup.link.url", { fg = c.string, underline = true })
hl(0, "@markup.italic", { italic = true })
hl(0, "@markup.strong", { bold = true })
hl(0, "@markup.raw", { fg = c.string })

-- LSP semantic tokens
hl(0, "@lsp.type.function", { link = "@function" })
hl(0, "@lsp.type.method", { link = "@method" })
hl(0, "@lsp.type.keyword", { link = "@keyword" })
hl(0, "@lsp.type.type", { link = "@type" })
hl(0, "@lsp.type.class", { fg = c.type })
hl(0, "@lsp.type.interface", { fg = c.type })
hl(0, "@lsp.type.enum", { fg = c.type })
hl(0, "@lsp.type.enumMember", { fg = c.const })
hl(0, "@lsp.type.variable", { link = "@variable" })
hl(0, "@lsp.type.parameter", { link = "@parameter" })
hl(0, "@lsp.type.property", { link = "@property" })
hl(0, "@lsp.type.namespace", { link = "@namespace" })
hl(0, "@lsp.type.decorator", { fg = c.fn })
hl(0, "@lsp.type.macro", { fg = c.keyword })
hl(0, "@lsp.type.comment", { link = "Comment" })
hl(0, "@lsp.type.string", { link = "@string" })
hl(0, "@lsp.type.number", { link = "@number" })
hl(0, "@lsp.type.boolean", { link = "@boolean" })
