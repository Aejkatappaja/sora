local M = {}

-- Other editors. The role map is the one lua/sora/groups/ uses, so a keyword is
-- purple here for the same reason it is purple there.

local palette = require("sora.palette")

--- @return string
function M.vim()
  local c = palette.colors

  --- @param width integer the column the attributes start at
  --- @return fun(group: string, attrs: string): string
  local function row(width)
    return function(group, attrs)
      return ("hi %-" .. width .. "s %s"):format(group, attrs)
    end
  end
  local hi, diag = row(13), row(24)

  local editor = {
    hi("Normal", ("guifg=%s guibg=%s"):format(c.fg, c.bg)),
    hi("NormalFloat", ("guifg=%s guibg=%s"):format(c.fg, c.bg_float)),
    hi("Cursor", ("guifg=%s guibg=%s"):format(c.bg, c.fg)),
    hi("CursorLine", ("guibg=%s cterm=NONE"):format(c.bg_cursorline)),
    hi("CursorLineNr", ("guifg=%s gui=bold"):format(c.accent)),
    hi("LineNr", ("guifg=%s"):format(c.fg_gutter)),
    hi("SignColumn", ("guifg=%s guibg=NONE"):format(c.fg_gutter)),
    hi("VertSplit", ("guifg=%s guibg=NONE"):format(c.border)),
    hi("StatusLine", ("guifg=%s guibg=%s"):format(c.fg, c.bg_float)),
    hi("StatusLineNC", ("guifg=%s guibg=%s"):format(c.fg_gutter, c.bg_float)),
    hi("TabLine", ("guifg=%s guibg=%s"):format(c.fg_dim, c.bg_float)),
    hi("TabLineFill", ("guibg=%s"):format(c.bg_float)),
    hi("TabLineSel", ("guifg=%s guibg=%s gui=bold"):format(c.fg_bright, c.bg)),
    hi("Pmenu", ("guifg=%s guibg=%s"):format(c.fg, c.bg_float)),
    hi("PmenuSel", ("guifg=%s guibg=%s"):format(c.fg_bright, c.bg_selection)),
    hi("PmenuSbar", ("guibg=%s"):format(c.bg_elevated)),
    hi("PmenuThumb", ("guibg=%s"):format(c.fg_gutter)),
    hi("Visual", ("guibg=%s"):format(c.bg_selection)),
    hi("Search", ("guifg=%s guibg=%s"):format(c.fg_bright, c.bg_search)),
    hi("IncSearch", ("guifg=%s guibg=%s"):format(c.bg, c.accent)),
    hi("MatchParen", ("guifg=%s gui=bold"):format(c.gold)),
    hi("NonText", ("guifg=%s"):format(c.border)),
    hi("SpecialKey", ("guifg=%s"):format(c.border)),
    hi("Folded", ("guifg=%s guibg=%s"):format(c.fg_comment, c.bg_elevated)),
    hi("ColorColumn", ("guibg=%s"):format(c.bg_cursorline)),
    hi("Directory", ("guifg=%s"):format(c.accent)),
    hi("Title", ("guifg=%s gui=bold"):format(c.accent)),
    hi("ErrorMsg", ("guifg=%s"):format(c.error)),
    hi("WarningMsg", ("guifg=%s"):format(c.warning)),
    hi("MoreMsg", ("guifg=%s"):format(c.accent)),
    hi("Question", ("guifg=%s"):format(c.accent)),
    hi("ModeMsg", ("guifg=%s gui=bold"):format(c.fg_bright)),
    hi("Conceal", ("guifg=%s"):format(c.fg_dim)),
    hi("EndOfBuffer", ("guifg=%s"):format(c.border)),
    hi("WildMenu", ("guifg=%s guibg=%s"):format(c.fg_bright, c.bg_selection)),
    hi("SpellBad", ("guisp=%s gui=undercurl"):format(c.error)),
    hi("SpellCap", ("guisp=%s gui=undercurl"):format(c.warning)),
  }

  local syntax = {
    hi("Comment", ("guifg=%s gui=italic"):format(c.fg_comment)),
    hi("String", ("guifg=%s"):format(c.sage)),
    hi("Character", ("guifg=%s"):format(c.sage)),
    hi("Number", ("guifg=%s"):format(c.gold)),
    hi("Float", ("guifg=%s"):format(c.gold)),
    hi("Boolean", ("guifg=%s gui=italic"):format(c.rose)),
    hi("Identifier", ("guifg=%s"):format(c.variable)),
    hi("Function", ("guifg=%s"):format(c.accent)),
    hi("Statement", ("guifg=%s"):format(c.purple)),
    hi("Conditional", ("guifg=%s gui=italic"):format(c.purple)),
    hi("Repeat", ("guifg=%s gui=italic"):format(c.purple)),
    hi("Label", ("guifg=%s"):format(c.teal)),
    hi("Operator", ("guifg=%s"):format(c.steel)),
    hi("Keyword", ("guifg=%s gui=italic"):format(c.purple)),
    hi("Exception", ("guifg=%s"):format(c.rose)),
    hi("PreProc", ("guifg=%s"):format(c.purple)),
    hi("Include", ("guifg=%s gui=italic"):format(c.purple)),
    hi("Define", ("guifg=%s"):format(c.purple)),
    hi("Macro", ("guifg=%s gui=bold"):format(c.teal)),
    hi("Type", ("guifg=%s"):format(c.peach)),
    hi("StorageClass", ("guifg=%s gui=italic"):format(c.purple)),
    hi("Structure", ("guifg=%s gui=bold"):format(c.peach)),
    hi("Typedef", ("guifg=%s"):format(c.peach)),
    hi("Constant", ("guifg=%s"):format(c.gold)),
    hi("Special", ("guifg=%s"):format(c.teal)),
    hi("SpecialChar", ("guifg=%s"):format(c.teal)),
    hi("Tag", ("guifg=%s"):format(c.teal)),
    hi("Delimiter", ("guifg=%s"):format(c.fg_dim)),
    hi("Debug", ("guifg=%s"):format(c.rose)),
    hi("Underlined", ("guifg=%s gui=underline"):format(c.accent)),
    hi("Error", ("guifg=%s"):format(c.error)),
    hi("Todo", ("guifg=%s guibg=%s gui=bold"):format(c.bg, c.gold)),
  }

  local diff = {
    hi("DiffAdd", ("guibg=%s"):format(c.diff_add_bg)),
    hi("DiffChange", ("guibg=%s"):format(c.diff_change_bg)),
    hi("DiffDelete", ("guibg=%s"):format(c.diff_delete_bg)),
    hi("DiffText", ("guibg=%s"):format(c.bg_selection)),
    hi("Added", ("guifg=%s"):format(c.git_add)),
    hi("Changed", ("guifg=%s"):format(c.git_change)),
    hi("Removed", ("guifg=%s"):format(c.git_delete)),
  }

  local diagnostics = {
    diag("DiagnosticError", ("guifg=%s"):format(c.error)),
    diag("DiagnosticWarn", ("guifg=%s"):format(c.warning)),
    diag("DiagnosticInfo", ("guifg=%s"):format(c.info)),
    diag("DiagnosticHint", ("guifg=%s"):format(c.hint)),
    diag("DiagnosticUnderlineError", ("guisp=%s gui=undercurl"):format(c.error)),
    diag("DiagnosticUnderlineWarn", ("guisp=%s gui=undercurl"):format(c.warning)),
    diag("DiagnosticUnderlineInfo", ("guisp=%s gui=undercurl"):format(c.info)),
    diag("DiagnosticUnderlineHint", ("guisp=%s gui=undercurl"):format(c.hint)),
  }

  local slots = {
    c.bg, c.error, c.sage, c.gold, c.accent, c.purple, c.teal, c.fg,
    c.fg_comment, c.terminal_bright_red, c.terminal_bright_green,
    c.terminal_bright_yellow, c.terminal_bright_blue,
    c.terminal_bright_magenta, c.terminal_bright_cyan, c.fg_bright,
  }
  local terminal = {}
  for i, hex in ipairs(slots) do
    terminal[i] = ("  let g:terminal_color_%-2d = '%s'"):format(i - 1, hex)
  end

  return ([[
" Sora colorscheme for Vim
" https://github.com/aejkatappaja/sora.nvim

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "sora"

if !has('gui_running') && &t_Co < 256
  finish
endif

" Editor
%s

" Syntax
%s

" Diff
%s

" Diagnostics
%s

" Terminal colors
if has('nvim')
%s
endif
]]):format(table.concat(editor, "\n"), table.concat(syntax, "\n"),
    table.concat(diff, "\n"), table.concat(diagnostics, "\n"),
    table.concat(terminal, "\n"))
end

--- Helix names its colours once and refers to them by name everywhere else, so
--- only the palette block at the bottom carries a value.
--- @return string
function M.helix()
  local c = palette.colors
  local keys = {
    "bg", "bg_float", "bg_elevated", "bg_cursorline", "bg_selection", "border",
    "guide", "fg", "fg_dim", "fg_bright", "fg_comment", "fg_gutter",
    "fg_gutter_active", "cyan", "purple", "sage", "rose", "gold", "peach",
    "teal", "steel", "variable", "git_add", "git_change", "git_delete", "error",
    "warning", "info", "hint",
  }
  local rows = {}
  for i, k in ipairs(keys) do rows[i] = ('%s = "%s"'):format(k, c[k]) end

  return ([[
# Sora theme for Helix (https://helix-editor.com).
# Install: copy to ~/.config/helix/themes/sora.toml, then set `theme = "sora"`
# in ~/.config/helix/config.toml.

# syntax
"keyword" = "purple"
"keyword.control" = "purple"
"keyword.directive" = "teal"
"operator" = "steel"
"function" = "cyan"
"function.builtin" = "cyan"
"function.method" = "cyan"
"function.macro" = "teal"
"constructor" = "peach"
"type" = "peach"
"type.builtin" = "peach"
"type.enum.variant" = "gold"
"constant" = "gold"
"constant.builtin" = "rose"
"constant.numeric" = "gold"
"constant.character" = "sage"
"constant.character.escape" = "teal"
"string" = "sage"
"string.regexp" = "teal"
"string.special" = "teal"
"comment" = { fg = "fg_comment", modifiers = ["italic"] }
"variable" = "variable"
"variable.builtin" = "rose"
"variable.parameter" = "fg"
"variable.other.member" = "steel"
"label" = "rose"
"punctuation" = "fg_dim"
"punctuation.delimiter" = "fg_dim"
"punctuation.bracket" = "fg_dim"
"tag" = "teal"
"namespace" = "peach"
"attribute" = "gold"
"special" = "purple"

# markup
"markup.heading" = { fg = "cyan", modifiers = ["bold"] }
"markup.bold" = { modifiers = ["bold"] }
"markup.italic" = { modifiers = ["italic"] }
"markup.strikethrough" = { modifiers = ["crossed_out"] }
"markup.link.url" = { fg = "steel", modifiers = ["underlined"] }
"markup.link.text" = "cyan"
"markup.link.label" = "purple"
"markup.raw" = "sage"
"markup.list" = "gold"
"markup.quote" = "fg_dim"

# diff
"diff.plus" = "git_add"
"diff.minus" = "git_delete"
"diff.delta" = "git_change"

# ui
"ui.background" = { bg = "bg" }
"ui.background.separator" = "border"
"ui.text" = "fg"
"ui.text.focus" = "fg_bright"
"ui.text.inactive" = "fg_comment"
"ui.text.directory" = "cyan"
"ui.cursor" = { fg = "bg", bg = "fg" }
"ui.cursor.primary" = { fg = "bg", bg = "cyan" }
"ui.cursor.match" = { fg = "gold", bg = "bg_selection" }
"ui.linenr" = "fg_gutter"
"ui.linenr.selected" = { fg = "fg_gutter_active", modifiers = ["bold"] }
"ui.gutter" = { bg = "bg" }
"ui.cursorline.primary" = { bg = "bg_cursorline" }
"ui.cursorline.secondary" = { bg = "bg_cursorline" }
"ui.selection" = { bg = "bg_selection" }
"ui.selection.primary" = { bg = "bg_selection" }
"ui.highlight" = { bg = "bg_selection" }
"ui.statusline" = { fg = "fg_dim", bg = "bg_float" }
"ui.statusline.inactive" = { fg = "fg_comment", bg = "bg_float" }
"ui.statusline.normal" = { fg = "bg", bg = "cyan", modifiers = ["bold"] }
"ui.statusline.insert" = { fg = "bg", bg = "sage", modifiers = ["bold"] }
"ui.statusline.select" = { fg = "bg", bg = "purple", modifiers = ["bold"] }
"ui.statusline.separator" = "border"
"ui.bufferline" = { fg = "fg_dim", bg = "bg_float" }
"ui.bufferline.active" = { fg = "fg_bright", bg = "bg_elevated" }
"ui.bufferline.background" = { bg = "bg_float" }
"ui.popup" = { fg = "fg", bg = "bg_elevated" }
"ui.popup.info" = { fg = "fg_dim", bg = "bg_elevated" }
"ui.window" = { fg = "border" }
"ui.help" = { fg = "fg", bg = "bg_elevated" }
"ui.menu" = { fg = "fg", bg = "bg_elevated" }
"ui.menu.selected" = { fg = "fg_bright", bg = "bg_selection" }
"ui.menu.scroll" = { fg = "fg_gutter", bg = "bg_float" }
"ui.virtual.whitespace" = "fg_gutter"
"ui.virtual.ruler" = { bg = "bg_elevated" }
"ui.virtual.indent-guide" = "guide"
"ui.virtual.inlay-hint" = { fg = "fg_comment", bg = "bg_elevated" }
"ui.virtual.jump-label" = { fg = "gold", modifiers = ["bold"] }

# diagnostics
"diagnostic.error" = { underline = { color = "error", style = "curl" } }
"diagnostic.warning" = { underline = { color = "warning", style = "curl" } }
"diagnostic.info" = { underline = { color = "info", style = "curl" } }
"diagnostic.hint" = { underline = { color = "hint", style = "curl" } }
"error" = "error"
"warning" = "warning"
"info" = "info"
"hint" = "hint"

[palette]
%s
]]):format(table.concat(rows, "\n"))
end

return M
