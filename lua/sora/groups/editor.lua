local M = {}

function M.get(c)
  return {
    Normal       = { fg = c.fg, bg = c.bg },
    NormalNC     = { fg = c.fg, bg = c.bg },
    NormalFloat  = { fg = c.fg, bg = c.bg_float },
    FloatBorder  = { fg = c.border, bg = c.bg_float },
    FloatTitle   = { fg = c.accent, bold = true },
    FloatShadow        = { bg = c.bg_float, blend = 80 },
    FloatShadowThrough = { bg = c.bg_float, blend = 100 },
    WinBar       = { fg = c.fg_dim, bg = c.none },
    WinBarNC     = { fg = c.fg_gutter, bg = c.none },

    Cursor       = { fg = c.bg, bg = c.fg },
    lCursor      = { link = "Cursor" },
    CursorIM     = { link = "Cursor" },
    TermCursor   = { fg = c.bg, bg = c.accent },
    TermCursorNC = { fg = c.bg, bg = c.fg_dim },
    CursorLine   = { bg = c.bg_cursorline },
    CursorColumn = { link = "CursorLine" },

    LineNr       = { fg = c.fg_gutter },
    CursorLineNr = { fg = c.accent, bold = true },
    SignColumn   = { fg = c.fg_gutter, bg = c.none },
    FoldColumn   = { fg = c.fg_gutter, bg = c.none },

    Search       = { fg = c.fg_bright, bg = c.bg_search },
    IncSearch    = { fg = c.bg, bg = c.accent },
    CurSearch    = { link = "IncSearch" },
    Substitute   = { fg = c.bg, bg = c.rose },

    Visual       = { bg = c.bg_selection },
    VisualNOS    = { link = "Visual" },

    StatusLine   = { fg = c.fg, bg = c.bg_statusline },
    StatusLineNC = { fg = c.fg_gutter, bg = c.bg_statusline },
    WinSeparator = { fg = c.border },
    VertSplit    = { link = "WinSeparator" },

    TabLine      = { fg = c.fg_dim, bg = c.bg_float },
    TabLineFill  = { bg = c.bg_float },
    TabLineSel   = { fg = c.fg_bright, bg = c.bg, bold = true },

    Pmenu        = { fg = c.fg, bg = c.bg_float },
    PmenuSel     = { fg = c.fg_bright, bg = c.bg_selection },
    PmenuSbar    = { bg = c.bg_elevated },
    PmenuThumb   = { bg = c.fg_gutter },
    PmenuKind    = { fg = c.purple, bg = c.bg_float },
    PmenuKindSel = { fg = c.purple, bg = c.bg_selection },
    PmenuExtra   = { fg = c.fg_dim, bg = c.bg_float },
    PmenuExtraSel = { fg = c.fg_dim, bg = c.bg_selection },

    Folded       = { fg = c.fg_comment, bg = c.bg_elevated },

    NonText      = { fg = c.nontext },
    SpecialKey   = { fg = c.nontext },
    Whitespace   = { fg = c.guide },
    EndOfBuffer  = { fg = c.nontext },
    MatchParen   = { fg = c.match_paren, bold = true },
    ModeMsg      = { fg = c.fg_bright, bold = true },
    MsgArea      = { fg = c.fg },
    MoreMsg      = { fg = c.cyan },
    Question     = { fg = c.cyan },
    Directory    = { fg = c.cyan },
    Title        = { fg = c.accent, bold = true },
    ErrorMsg     = { fg = c.error },
    WarningMsg   = { fg = c.warning },
    OkMsg        = { fg = c.ok },
    Conceal      = { fg = c.fg_dim },
    SpellBad     = { sp = c.error, undercurl = true },
    SpellCap     = { sp = c.warning, undercurl = true },
    SpellLocal   = { sp = c.info, undercurl = true },
    SpellRare    = { sp = c.hint, undercurl = true },
    ColorColumn  = { bg = c.bg_cursorline },
    QuickFixLine = { bg = c.bg_selection, bold = true },
    WildMenu     = { link = "PmenuSel" },
  }
end

return M
