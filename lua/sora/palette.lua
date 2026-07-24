local M = {}

-- Dark - deep blue-black, the sky before dawn
M.dark = {
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

-- Light - cool off-white, the sky at daybreak
M.light = {
  -- Backgrounds - cool off-white, faint blue tint
  bg            = "#eceff4",
  bg_float      = "#e3e7ef",
  bg_elevated   = "#f5f7fb",
  bg_cursorline = "#e2e6ee",
  bg_selection  = "#d3dcea",
  bg_search     = "#cfe0f2",
  bg_statusline = "#e3e7ef",

  -- Foregrounds - dark cool slate
  fg            = "#3a4256",
  fg_dim        = "#5a6478",
  fg_bright     = "#2a3040",
  fg_comment    = "#8a93a6",
  fg_gutter     = "#b8c0d0",
  fg_gutter_active = "#7a8498",

  -- Syntax - deepened so accents read on a light ground
  cyan      = "#2c8fb0",
  purple    = "#7a5fb8",
  sage      = "#3f9668",
  rose      = "#c05068",
  gold      = "#9a7d1e",
  peach     = "#bf6a3a",
  teal      = "#2f8b82",
  steel     = "#5a6a90",

  -- Aliases for highlight groups
  keyword   = "#7a5fb8",
  func      = "#2c8fb0",
  string    = "#3f9668",
  type      = "#bf6a3a",
  constant  = "#9a7d1e",
  variable  = "#454d63",
  operator  = "#5a6a90",
  special   = "#7a5fb8",
  tag       = "#2f8b82",
  regex     = "#2f8b82",

  -- UI
  accent      = "#2c8fb0",
  border      = "#cdd4e0",
  match_paren = "#9a7d1e",
  guide       = "#dde2ec",
  guide_active = "#c4ccdc",
  nontext     = "#cdd4e0",

  -- Diagnostics
  error   = "#c04858",
  warning = "#b0801e",
  info    = "#2c7fa8",
  hint    = "#3f8a78",
  ok      = "#3f9668",

  -- Git
  git_add    = "#3f9668",
  git_change = "#3a7fb0",
  git_delete = "#c04858",
  git_ignore = "#8a93a6",

  -- Diff backgrounds
  diff_add_bg    = "#dcefe2",
  diff_change_bg = "#dde8f5",
  diff_delete_bg = "#f5dde0",
  diff_text_bg   = "#cfe0f2",

  -- Terminal
  terminal_black   = "#2a3040",
  terminal_red     = "#c04858",
  terminal_green   = "#3f9668",
  terminal_yellow  = "#9a7d1e",
  terminal_blue    = "#2c8fb0",
  terminal_magenta = "#7a5fb8",
  terminal_cyan    = "#2f8b82",
  terminal_white   = "#c8cfda",

  terminal_bright_black   = "#5a6478",
  terminal_bright_red     = "#d05a6a",
  terminal_bright_green   = "#4fa878",
  terminal_bright_yellow  = "#b0902a",
  terminal_bright_blue    = "#3aa0c0",
  terminal_bright_magenta = "#8f74c8",
  terminal_bright_cyan    = "#3f9b92",
  terminal_bright_white   = "#eceff4",

  none = "NONE",
}

-- Backward-compatible default (dark)
M.colors = M.dark

return M
