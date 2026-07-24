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
  -- Backgrounds - dimmed cool off-white, lower glare than a paper white
  bg            = "#e4e7ee",
  bg_float      = "#dbe0e9",
  bg_elevated   = "#eef1f6",
  bg_cursorline = "#dadfe9",
  bg_selection  = "#ccd4e3",
  bg_search     = "#c3d6ee",
  bg_statusline = "#dbe0e9",

  -- Foregrounds - dark cool slate, all >= AA on bg
  fg            = "#323f59",
  fg_dim        = "#505b72",
  fg_bright     = "#1e2e47",
  fg_comment    = "#586478",
  fg_gutter     = "#aab3c5",
  fg_gutter_active = "#656f86",

  -- Syntax - deepened to clear WCAG AA (>= 4.8:1) on the light ground
  cyan      = "#206b84",
  purple    = "#6e51b8",
  sage      = "#376f47",
  rose      = "#a24556",
  gold      = "#796027",
  peach     = "#875935",
  teal      = "#396c66",
  steel     = "#516489",

  -- Aliases for highlight groups
  keyword   = "#6e51b8",
  func      = "#206b84",
  string    = "#376f47",
  type      = "#875935",
  constant  = "#796027",
  variable  = "#444f6c",
  operator  = "#516489",
  special   = "#6e51b8",
  tag       = "#396c66",
  regex     = "#396c66",

  -- UI
  accent      = "#206b84",
  border      = "#c2cad9",
  match_paren = "#796027",
  guide       = "#d2d8e4",
  guide_active = "#b8c1d2",
  nontext     = "#c2cad9",

  -- Diagnostics
  error   = "#bd2739",
  warning = "#796027",
  info    = "#236a8e",
  hint    = "#306e5c",
  ok      = "#376f47",

  -- Git
  git_add    = "#376f47",
  git_change = "#29679a",
  git_delete = "#bd2739",
  git_ignore = "#586478",

  -- Diff backgrounds
  diff_add_bg    = "#d3e8da",
  diff_change_bg = "#d4e1f0",
  diff_delete_bg = "#eed3d7",
  diff_text_bg   = "#c3d6ee",

  -- Terminal
  terminal_black   = "#1e2e47",
  terminal_red     = "#bd2739",
  terminal_green   = "#376f47",
  terminal_yellow  = "#796027",
  terminal_blue    = "#206b84",
  terminal_magenta = "#6e51b8",
  terminal_cyan    = "#396c66",
  terminal_white   = "#b8c0cf",

  terminal_bright_black   = "#505b72",
  terminal_bright_red     = "#b85869",
  terminal_bright_green   = "#418354",
  terminal_bright_yellow  = "#90722e",
  terminal_bright_blue    = "#267f9d",
  terminal_bright_magenta = "#8067c1",
  terminal_bright_cyan    = "#448079",
  terminal_bright_white   = "#e4e7ee",

  none = "NONE",
}

-- Backward-compatible default (dark)
M.colors = M.dark

return M
