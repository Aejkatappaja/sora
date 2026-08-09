local M = {}

M.colors = {
  -- Backgrounds - deep blue-black, almost OLED, like the sky above
  bg            = "#0e1018",
  bg_float      = "#0a0c12",
  bg_elevated   = "#14161e",
  bg_cursorline = "#171a24",
  bg_selection  = "#1e2430",
  bg_search     = "#1a3050",
  bg_statusline = "#0a0c12",

  -- Foregrounds - cool silver, like starlight
  fg            = "#c8d0e0",
  fg_dim        = "#9aa4b8",
  fg_bright     = "#dce4f0",
  fg_comment    = "#586478",
  fg_gutter     = "#364050",
  fg_gutter_active = "#6a7890",

  -- Syntax
  cyan      = "#80c8e0",  -- THE signature - ethereal cyan, functions
  purple    = "#b0a0d8",  -- keywords
  sage      = "#90c8a0",  -- strings
  rose      = "#d0909c",  -- booleans, builtins, exceptions
  gold      = "#d4b878",  -- constants, numbers - the warm "star"
  peach     = "#d0a888",  -- types, constructors
  teal      = "#78b8b0",  -- tags, regex, escapes
  steel     = "#8898b8",  -- operators, properties

  -- Aliases for highlight groups
  keyword   = "#b0a0d8",
  func      = "#80c8e0",
  string    = "#90c8a0",
  type      = "#d0a888",
  constant  = "#d4b878",
  variable  = "#b4bcd0",
  operator  = "#8898b8",
  special   = "#b0a0d8",
  tag       = "#78b8b0",
  regex     = "#78b8b0",

  -- UI
  accent      = "#80c8e0",
  border      = "#222838",
  match_paren = "#d4b878",
  guide       = "#181c26",
  guide_active = "#282e3c",
  nontext     = "#222838",

  -- Diagnostics
  error   = "#c46c78",
  warning = "#c8a860",
  info    = "#5ca8c8",
  hint    = "#78b0a0",
  ok      = "#68a888",

  -- Git
  git_add    = "#68b080",
  git_change = "#6898b8",
  git_delete = "#b86068",
  git_ignore = "#586478",

  -- Diff backgrounds
  diff_add_bg    = "#0e1c16",
  diff_change_bg = "#101828",
  diff_delete_bg = "#1c1014",
  diff_text_bg   = "#1e2430",

  -- Word level diff, a step above the line grounds above. Named here rather than
  -- left as literals in extras/, which is what the generator renders from.
  diff_add_emph     = "#142c1c",
  diff_delete_emph  = "#2a1420",
  diff_add_word     = "#163524",
  diff_delete_word  = "#35161c",
  diff_moved_add    = "#0d1f22",
  diff_moved_delete = "#171426",

  -- The row under the cursor in a list that is not a floating window
  bg_selected = "#283448",

  -- One ground per heading level, each tinted toward the colour that level wears
  heading_1_bg = "#141826",
  heading_2_bg = "#14161e",
  heading_3_bg = "#161820",
  heading_4_bg = "#141a18",
  heading_5_bg = "#181818",
  heading_6_bg = "#181418",

  -- Terminal
  terminal_black   = "#0e1018",
  terminal_red     = "#c46c78",
  terminal_green   = "#90c8a0",
  terminal_yellow  = "#d4b878",
  terminal_blue    = "#80c8e0",
  terminal_magenta = "#b0a0d8",
  terminal_cyan    = "#78b8b0",
  terminal_white   = "#c8d0e0",

  terminal_bright_black   = "#4a5468",
  terminal_bright_red     = "#d88898",
  terminal_bright_green   = "#a8d8b4",
  terminal_bright_yellow  = "#e0c888",
  terminal_bright_blue    = "#98d8f0",
  terminal_bright_magenta = "#c4b4e8",
  terminal_bright_cyan    = "#90d0c8",
  terminal_bright_white   = "#dce4f0",

  none = "NONE",
}

return M
