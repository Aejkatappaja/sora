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

return M
