local M = {}

function M.get(c)
  return {
    -- Git signs
    GitSignsAdd    = { fg = c.git_add },
    GitSignsChange = { fg = c.git_change },
    GitSignsDelete = { fg = c.git_delete },

    -- Diff
    DiffAdd    = { bg = c.diff_add_bg },
    DiffChange = { bg = c.diff_change_bg },
    DiffDelete = { bg = c.diff_delete_bg },
    DiffText   = { bg = c.diff_text_bg },
    Added      = { fg = c.git_add },
    Changed    = { fg = c.git_change },
    Removed    = { fg = c.git_delete },

    -- Telescope
    TelescopeBorder        = { link = "FloatBorder" },
    TelescopeNormal        = { link = "NormalFloat" },
    TelescopePromptBorder  = { link = "FloatBorder" },
    TelescopePromptNormal  = { link = "NormalFloat" },
    TelescopePromptPrefix  = { fg = c.accent },
    TelescopePromptTitle   = { fg = c.accent, bold = true },
    TelescopePreviewTitle  = { fg = c.sage, bold = true },
    TelescopeResultsTitle  = { fg = c.purple, bold = true },
    TelescopeSelection     = { bg = c.bg_selection },
    TelescopeMatching      = { fg = c.accent, bold = true },

    -- nvim-cmp
    CmpItemAbbr            = { fg = c.fg },
    CmpItemAbbrDeprecated  = { fg = c.fg_gutter, strikethrough = true },
    CmpItemAbbrMatch       = { fg = c.accent, bold = true },
    CmpItemAbbrMatchFuzzy  = { fg = c.accent, bold = true },
    CmpItemMenu            = { fg = c.fg_comment },
    CmpItemKindDefault     = { fg = c.fg_dim },
    CmpItemKindKeyword     = { fg = c.purple },
    CmpItemKindVariable    = { fg = c.variable },
    CmpItemKindConstant    = { fg = c.gold },
    CmpItemKindReference   = { fg = c.variable },
    CmpItemKindValue       = { fg = c.gold },
    CmpItemKindFunction    = { fg = c.cyan },
    CmpItemKindMethod      = { fg = c.cyan },
    CmpItemKindConstructor = { fg = c.peach },
    CmpItemKindClass       = { fg = c.peach },
    CmpItemKindInterface   = { fg = c.peach },
    CmpItemKindStruct      = { fg = c.peach },
    CmpItemKindEvent       = { fg = c.purple },
    CmpItemKindEnum        = { fg = c.peach },
    CmpItemKindUnit        = { fg = c.gold },
    CmpItemKindModule      = { fg = c.fg_dim },
    CmpItemKindProperty    = { fg = c.steel },
    CmpItemKindField       = { fg = c.steel },
    CmpItemKindTypeParameter = { fg = c.peach },
    CmpItemKindEnumMember  = { fg = c.gold },
    CmpItemKindOperator    = { fg = c.steel },
    CmpItemKindSnippet     = { fg = c.teal },
    CmpItemKindText        = { fg = c.fg },
    CmpItemKindFile        = { fg = c.fg },
    CmpItemKindFolder      = { fg = c.cyan },
    CmpItemKindColor       = { fg = c.teal },

    -- blink.cmp
    BlinkCmpMenu           = { fg = c.fg, bg = c.bg_float },
    BlinkCmpMenuBorder     = { fg = c.border, bg = c.bg_float },
    BlinkCmpMenuSelection  = { bg = c.bg_selection },
    BlinkCmpLabel          = { fg = c.fg },
    BlinkCmpLabelMatch     = { fg = c.accent, bold = true },
    BlinkCmpLabelDeprecated = { fg = c.fg_gutter, strikethrough = true },
    BlinkCmpKind           = { fg = c.fg_dim },
    BlinkCmpKindFunction   = { fg = c.cyan },
    BlinkCmpKindMethod     = { fg = c.cyan },
    BlinkCmpKindConstructor = { fg = c.peach },
    BlinkCmpKindClass      = { fg = c.peach },
    BlinkCmpKindStruct     = { fg = c.peach },
    BlinkCmpKindInterface  = { fg = c.peach },
    BlinkCmpKindModule     = { fg = c.fg_dim },
    BlinkCmpKindProperty   = { fg = c.steel },
    BlinkCmpKindField      = { fg = c.steel },
    BlinkCmpKindVariable   = { fg = c.variable },
    BlinkCmpKindKeyword    = { fg = c.purple },
    BlinkCmpKindSnippet    = { fg = c.teal },
    BlinkCmpKindText       = { fg = c.fg },
    BlinkCmpKindValue      = { fg = c.gold },
    BlinkCmpKindEnum       = { fg = c.peach },
    BlinkCmpKindColor      = { fg = c.teal },
    BlinkCmpKindFile       = { fg = c.fg },
    BlinkCmpKindFolder     = { fg = c.cyan },
    BlinkCmpKindConstant   = { fg = c.gold },
    BlinkCmpKindTypeParameter = { fg = c.peach },
    BlinkCmpKindOperator   = { fg = c.steel },
    BlinkCmpDoc            = { fg = c.fg, bg = c.bg_float },
    BlinkCmpDocBorder      = { fg = c.border, bg = c.bg_float },

    -- Indent blankline
    IblIndent    = { fg = c.guide },
    IblScope     = { fg = c.guide_active },
    IblWhitespace = { fg = c.guide },

    -- Which-key
    WhichKey          = { fg = c.cyan },
    WhichKeyGroup     = { fg = c.purple },
    WhichKeyDesc      = { fg = c.fg },
    WhichKeySeparator = { fg = c.fg_comment },
    WhichKeyValue     = { fg = c.fg_dim },
    WhichKeyBorder    = { fg = c.border },

    -- Trouble
    TroubleText   = { fg = c.fg },
    TroubleCount  = { fg = c.accent, bold = true },
    TroubleNormal = { link = "NormalFloat" },

    -- Nvim-tree
    NvimTreeNormal      = { link = "NormalFloat" },
    NvimTreeRootFolder  = { fg = c.cyan, bold = true },
    NvimTreeFolderName  = { fg = c.cyan },
    NvimTreeFolderIcon  = { fg = c.cyan },
    NvimTreeOpenedFolderName = { fg = c.cyan, bold = true },
    NvimTreeGitDirty    = { fg = c.git_change },
    NvimTreeGitNew      = { fg = c.git_add },
    NvimTreeGitDeleted  = { fg = c.git_delete },
    NvimTreeGitIgnored  = { fg = c.git_ignore },
    NvimTreeSpecialFile = { fg = c.gold },
    NvimTreeIndentMarker = { fg = c.guide },
    NvimTreeWinSeparator = { fg = c.border },

    -- Neo-tree
    NeoTreeNormal       = { link = "NormalFloat" },
    NeoTreeNormalNC     = { link = "NormalFloat" },
    NeoTreeDimText      = { fg = c.fg_dim },
    NeoTreeRootName     = { fg = c.cyan, bold = true },
    NeoTreeDirectoryName = { fg = c.cyan },
    NeoTreeDirectoryIcon = { fg = c.cyan },
    NeoTreeGitAdded     = { fg = c.git_add },
    NeoTreeGitModified  = { fg = c.git_change },
    NeoTreeGitDeleted   = { fg = c.git_delete },
    NeoTreeGitIgnored   = { fg = c.git_ignore },
    NeoTreeIndentMarker = { fg = c.guide },
    NeoTreeWinSeparator = { fg = c.border },

    -- Lazy
    LazyButton       = { fg = c.fg, bg = c.bg_elevated },
    LazyButtonActive = { fg = c.fg_bright, bg = c.bg_selection, bold = true },
    LazyH1           = { fg = c.bg, bg = c.cyan, bold = true },
    LazyProgressDone = { fg = c.cyan },
    LazyProgressTodo = { fg = c.fg_gutter },
    LazySpecial      = { fg = c.cyan },

    -- Mason
    MasonHeader         = { fg = c.bg, bg = c.cyan, bold = true },
    MasonHighlight      = { fg = c.cyan },
    MasonHighlightBlock = { fg = c.bg, bg = c.cyan },
    MasonMutedBlock     = { fg = c.fg, bg = c.bg_elevated },

    -- Noice
    NoiceCmdlinePopup       = { link = "NormalFloat" },
    NoiceCmdlinePopupBorder = { fg = c.border },
    NoiceCmdlineIcon        = { fg = c.cyan },
    NoiceConfirm            = { link = "NormalFloat" },
    NoiceConfirmBorder      = { fg = c.border },

    -- Notify
    NotifyERRORBorder = { fg = c.error },
    NotifyERRORIcon   = { fg = c.error },
    NotifyERRORTitle  = { fg = c.error },
    NotifyWARNBorder  = { fg = c.warning },
    NotifyWARNIcon    = { fg = c.warning },
    NotifyWARNTitle   = { fg = c.warning },
    NotifyINFOBorder  = { fg = c.info },
    NotifyINFOIcon    = { fg = c.info },
    NotifyINFOTitle   = { fg = c.info },
    NotifyDEBUGBorder = { fg = c.fg_comment },
    NotifyDEBUGIcon   = { fg = c.fg_comment },
    NotifyDEBUGTitle  = { fg = c.fg_comment },
    NotifyTRACEBorder = { fg = c.purple },
    NotifyTRACEIcon   = { fg = c.purple },
    NotifyTRACETitle  = { fg = c.purple },

    -- Mini
    MiniStatuslineModeNormal  = { fg = c.bg, bg = c.cyan, bold = true },
    MiniStatuslineModeInsert  = { fg = c.bg, bg = c.sage, bold = true },
    MiniStatuslineModeVisual  = { fg = c.bg, bg = c.purple, bold = true },
    MiniStatuslineModeReplace = { fg = c.bg, bg = c.rose, bold = true },
    MiniStatuslineModeCommand = { fg = c.bg, bg = c.gold, bold = true },
    MiniStatuslineModeOther   = { fg = c.bg, bg = c.teal, bold = true },
    MiniStatuslineFilename    = { fg = c.fg, bg = c.bg_elevated },
    MiniStatuslineFileinfo    = { fg = c.fg_dim, bg = c.bg_elevated },
    MiniStatuslineDevinfo     = { fg = c.fg_dim, bg = c.bg_elevated },
    MiniStatuslineInactive    = { fg = c.fg_gutter, bg = c.bg_statusline },

    -- Snacks
    SnacksIndent      = { fg = c.guide },
    SnacksIndentScope = { fg = c.guide_active },

    -- Flash
    FlashLabel   = { fg = c.bg, bg = c.cyan, bold = true },
    FlashMatch   = { fg = c.fg_dim, bg = c.bg_selection },
    FlashCurrent = { fg = c.fg_bright, bg = c.bg_search },

    -- Treesitter context
    TreesitterContext           = { bg = c.bg_elevated },
    TreesitterContextLineNumber = { fg = c.fg_gutter_active, bg = c.bg_elevated },

    -- Dashboard / Alpha
    DashboardHeader  = { fg = c.cyan },
    DashboardFooter  = { fg = c.fg_comment, italic = true },
    DashboardDesc    = { fg = c.fg },
    DashboardKey     = { fg = c.gold },
    DashboardIcon    = { fg = c.cyan },
    DashboardShortCut = { fg = c.purple },

    -- Render-markdown
    RenderMarkdownH1Bg  = { bg = "#141826" },
    RenderMarkdownH2Bg  = { bg = "#14161e" },
    RenderMarkdownH3Bg  = { bg = "#161820" },
    RenderMarkdownH4Bg  = { bg = "#141a18" },
    RenderMarkdownH5Bg  = { bg = "#181818" },
    RenderMarkdownH6Bg  = { bg = "#181418" },
    RenderMarkdownCode  = { bg = c.bg_elevated },

    -- Oil
    OilDir     = { fg = c.cyan },
    OilDirIcon = { fg = c.cyan },
    OilFile    = { fg = c.fg },
    OilCreate  = { fg = c.git_add },
    OilDelete  = { fg = c.git_delete },
    OilMove    = { fg = c.git_change },
    OilCopy    = { fg = c.info },

    -- Fzf-lua
    FzfLuaBorder   = { fg = c.border },
    FzfLuaTitle    = { fg = c.accent, bold = true },
    FzfLuaCursorLine = { bg = c.bg_selection },
  }
end

return M
