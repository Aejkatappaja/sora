local M = {}

-- Pagers, prompts and TUIs. Same rule as the terminals: rendered from
-- lua/sora/palette.lua and nothing else.

local palette = require("sora.palette")

--- @return string
function M.fzf()
  local c = palette.colors
  return ([[
# Sora theme for fzf
# https://github.com/aejkatappaja/sora.nvim
#
# Source this file or add to your shell rc:
#   source /path/to/sora.sh

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color=bg+:%s \
  --color=bg:%s \
  --color=border:%s \
  --color=fg:%s \
  --color=fg+:%s \
  --color=gutter:%s \
  --color=header:%s \
  --color=hl:%s \
  --color=hl+:%s \
  --color=info:%s \
  --color=marker:%s \
  --color=pointer:%s \
  --color=prompt:%s \
  --color=query:%s \
  --color=scrollbar:%s \
  --color=separator:%s \
  --color=spinner:%s"
]]):format(c.bg_selection, c.bg, c.border, c.fg, c.fg_bright, c.bg, c.accent,
    c.accent, c.terminal_bright_blue, c.fg_comment, c.sage, c.accent, c.purple,
    c.fg, c.border, c.border, c.accent)
end

--- @return string
function M.delta()
  local c = palette.colors
  return ([[
# Sora theme for delta (git-delta)
# https://github.com/aejkatappaja/sora.nvim
#
# Add to your .gitconfig:
#   [include]
#     path = /path/to/sora.gitconfig
#
# For syntax highlighting, install the bat theme:
#   cp /path/to/extras/bat/sora.tmTheme "$(bat --config-dir)/themes/"
#   bat cache --build

[delta]
  syntax-theme = Sora
  minus-style = syntax "%s"
  minus-emph-style = syntax bold "%s"
  plus-style = syntax "%s"
  plus-emph-style = syntax bold "%s"
  hunk-header-style = "%s" italic
  hunk-header-decoration-style = "%s" box
  file-style = "%s" bold
  file-decoration-style = "%s" ul
  line-numbers-minus-style = "%s"
  line-numbers-plus-style = "%s"
  line-numbers-zero-style = "%s"
  line-numbers-left-style = "%s"
  line-numbers-right-style = "%s"
  commit-decoration-style = "%s" box
  commit-style = "%s" bold
  blame-palette = "%s" "%s" "%s" "%s"
]]):format(c.diff_delete_bg, c.diff_delete_emph, c.diff_add_bg, c.diff_add_emph,
    c.fg_dim, c.border, c.accent, c.accent, c.error, c.git_add, c.fg_gutter,
    c.fg_gutter, c.fg_gutter, c.accent, c.gold,
    c.bg, c.bg_elevated, c.bg_cursorline, c.bg_selection)
end

--- @return string
function M.lazygit()
  local c = palette.colors
  return ([[
gui:
  nerdFontsVersion: "3"
  theme:
    activeBorderColor:
      - "%s"
      - "bold"
    inactiveBorderColor:
      - "%s"
    searchingActiveBorderColor:
      - "%s"
      - "bold"
    optionsTextColor:
      - "%s"
    selectedLineBgColor:
      - "%s"
    inactiveViewSelectedLineBgColor:
      - "%s"
    cherryPickedCommitFgColor:
      - "%s"
    cherryPickedCommitBgColor:
      - "%s"
    markedBaseCommitFgColor:
      - "%s"
    markedBaseCommitBgColor:
      - "%s"
    unstagedChangesColor:
      - "%s"
    defaultFgColor:
      - "%s"
]]):format(c.accent, c.fg_comment, c.gold, c.accent, c.bg_selected,
    c.bg_selection, c.accent, c.purple, c.accent, c.gold, c.error, c.fg)
end

--- eza writes truecolor SGR rather than hex, so the palette is converted here.
--- @return string
function M.eza()
  local c = palette.colors

  --- @param hex string
  --- @return string
  local function rgb(hex)
    local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)$")
    return ("%d;%d;%d"):format(tonumber(r, 16), tonumber(g, 16), tonumber(b, 16))
  end

  -- code, colour, and the trailing attribute eza appends to a couple of them
  local slots = {
    { "di", c.cyan, ";1" }, { "ex", c.sage }, { "fi", c.fg }, { "ln", c.purple },
    { "or", c.git_delete }, { "pi", c.teal }, { "so", c.purple }, { "bd", c.gold },
    { "cd", c.peach }, { "ur", c.gold }, { "uw", c.rose }, { "ux", c.sage },
    { "ue", c.sage }, { "gr", c.gold }, { "gw", c.rose }, { "gx", c.sage },
    { "tr", c.gold }, { "tw", c.rose }, { "tx", c.sage }, { "su", c.peach },
    { "sf", c.peach }, { "xa", c.steel }, { "sn", c.fg }, { "sb", c.fg_dim },
    { "uu", c.gold }, { "un", c.fg_dim }, { "gu", c.peach }, { "gn", c.fg_dim },
    { "da", c.steel }, { "in", c.fg_comment }, { "lc", c.steel }, { "lp", c.purple },
    { "ga", c.git_add }, { "gm", c.git_change }, { "gd", c.git_delete },
    { "gv", c.purple }, { "gt", c.gold }, { "gi", c.fg_comment }, { "gc", c.rose },
    { "xx", c.fg_comment }, { "hd", c.fg_bright, ";1" },
  }

  local lines = {}
  for i, s in ipairs(slots) do
    -- every entry but the last carries the colon that separates them
    local tail = i == #slots and '"' or ':\\'
    lines[i] = ("%s=38;2;%s%s%s"):format(s[1], rgb(s[2]), s[3] or "", tail)
  end

  return ([[
# Sora theme for eza (https://eza.rocks).
# Install: source this file from your shell rc (~/.zshrc, ~/.bashrc, config.fish).
#   source /path/to/extras/eza/sora.sh
# Truecolor (38;2;R;G;B), mapped from the Sora palette.

export EZA_COLORS="\
%s
]]):format(table.concat(lines, "\n"))
end

--- Slack takes its theme as one comma separated line, pasted into the client.
--- @return string
function M.slack()
  local c = palette.colors
  return ("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n"):format(
    c.bg, c.bg_float, c.accent, c.fg, c.bg_selection, c.fg, c.sage, c.accent,
    c.bg, c.fg)
end

--- @return string
function M.starship()
  local c = palette.colors
  return ([[
# Sora palette for Starship.
# Install: copy into ~/.config/starship.toml, or if you keep your own config,
# copy the [palettes.sora] block below and add `palette = "sora"` at the top.

palette = "sora"

[palettes.sora]
bg          = "%s"
fg          = "%s"
fg_dim      = "%s"
cyan        = "%s"
purple      = "%s"
sage        = "%s"
rose        = "%s"
gold        = "%s"
peach       = "%s"
teal        = "%s"
steel       = "%s"
git_add     = "%s"
git_change  = "%s"
git_delete  = "%s"
error       = "%s"
warning     = "%s"

[directory]
style = "cyan bold"

[git_branch]
style = "purple"

[git_status]
style = "rose"

[git_state]
style = "gold"

[cmd_duration]
style = "gold"

[hostname]
style = "steel"

[username]
style_user = "steel"
style_root = "rose bold"

[time]
style = "fg_dim"

[character]
success_symbol = "[❯](sage)"
error_symbol   = "[❯](error)"
vimcmd_symbol  = "[❮](purple)"

[nodejs]
style = "sage"

[rust]
style = "peach"

[python]
style = "gold"

[golang]
style = "cyan"

[lua]
style = "purple"

[docker_context]
style = "teal"

[package]
style = "gold"
]]):format(c.bg, c.fg, c.fg_dim, c.cyan, c.purple, c.sage, c.rose, c.gold,
    c.peach, c.teal, c.steel, c.git_add, c.git_change, c.git_delete, c.error,
    c.warning)
end

--- Ordered rows rather than one positional template: btop takes sixty keys, and a
--- line inserted in the middle of a format string shifts every colour after it.
--- @return string
function M.btop()
  local c = palette.colors
  local rows = {
    "# Main background and text",
    { "main_bg", c.bg }, { "main_fg", c.fg }, { "title", c.fg },
    { "hi_fg", c.accent }, { "selected_bg", c.bg_selection },
    { "selected_fg", c.fg_bright }, { "inactive_fg", c.fg_comment },
    { "graph_text", c.fg_dim }, { "meter_bg", c.border },
    "",
    "# Graph colors",
    { "proc_misc", c.accent }, { "cpu_box", c.accent }, { "mem_box", c.purple },
    { "net_box", c.sage }, { "proc_box", c.peach }, { "div_line", c.border },
    "",
    "# Temperature",
    { "temp_start", c.sage }, { "temp_mid", c.gold }, { "temp_end", c.error },
    "",
    "# CPU",
    { "cpu_start", c.accent }, { "cpu_mid", c.purple }, { "cpu_end", c.rose },
    "",
    "# Free/cached/available memory",
    { "free_start", c.sage }, { "free_mid", c.teal }, { "free_end", c.sage },
    "",
    { "cached_start", c.purple }, { "cached_mid", c.purple },
    { "cached_end", c.terminal_bright_magenta },
    "",
    { "available_start", c.gold }, { "available_mid", c.peach },
    { "available_end", c.gold },
    "",
    "# Used memory",
    { "used_start", c.accent }, { "used_mid", c.purple }, { "used_end", c.rose },
    "",
    "# Download/Upload",
    { "download_start", c.accent }, { "download_mid", c.terminal_bright_blue },
    { "download_end", c.accent },
    "",
    { "upload_start", c.purple }, { "upload_mid", c.terminal_bright_magenta },
    { "upload_end", c.purple },
    "",
    "# Process",
    { "process_start", c.accent }, { "process_mid", c.teal },
    { "process_end", c.sage },
  }

  local lines = {}
  for i, row in ipairs(rows) do
    lines[i] = type(row) == "string" and row or ('theme[%s]="%s"'):format(row[1], row[2])
  end

  return ([[
# Sora theme for btop
# https://github.com/aejkatappaja/sora.nvim

%s
]]):format(table.concat(lines, "\n"))
end

--- @return string
function M.firefox()
  local c = palette.colors
  return ([[
{
  "manifest_version": 2,
  "name": "Sora",
  "short_name": "sora",
  "version": "1.0.0",
  "description": "Sora theme for Firefox — a moody dark palette with cyan accents.",
  "author": "anton",
  "homepage_url": "https://github.com/Aejkatappaja/sora",

  "browser_specific_settings": {
    "gecko": {
      "id": "sora@aejkatappaja.theme",
      "strict_min_version": "60.0"
    }
  },

  "theme": {
    "colors": {
      "frame":                       "%s",
      "frame_inactive":              "%s",

      "tab_background_text":         "%s",
      "tab_text":                    "%s",
      "tab_selected":                "%s",
      "tab_line":                    "%s",
      "tab_loading":                 "%s",
      "tab_background_separator":    "%s",

      "toolbar":                     "%s",
      "toolbar_text":                "%s",
      "toolbar_top_separator":       "%s",
      "toolbar_bottom_separator":    "%s",
      "toolbar_vertical_separator":  "%s",

      "toolbar_field":               "%s",
      "toolbar_field_text":          "%s",
      "toolbar_field_border":        "%s",
      "toolbar_field_focus":         "%s",
      "toolbar_field_text_focus":    "%s",
      "toolbar_field_border_focus":  "%s",
      "toolbar_field_highlight":     "%s",
      "toolbar_field_highlight_text":"%s",

      "popup":                       "%s",
      "popup_text":                  "%s",
      "popup_border":                "%s",
      "popup_highlight":             "%s",
      "popup_highlight_text":        "%s",

      "sidebar":                     "%s",
      "sidebar_text":                "%s",
      "sidebar_border":              "%s",
      "sidebar_highlight":           "%s",
      "sidebar_highlight_text":      "%s",

      "bookmark_text":               "%s",
      "button_background_active":    "%s",
      "button_background_hover":     "%s",
      "icons":                       "%s",
      "icons_attention":             "%s",

      "ntp_background":              "%s",
      "ntp_text":                    "%s"
    }
  }
}
]]):format(c.bg_float, c.bg_float, c.fg_dim, c.fg_bright, c.bg, c.accent, c.gold,
    c.border, c.bg, c.fg, c.bg_float, c.border, c.border, c.bg_elevated,
    c.fg_bright, c.border, c.bg_cursorline, c.fg_bright, c.accent,
    c.bg_selection, c.fg_bright, c.bg, c.fg, c.border, c.bg_selection,
    c.fg_bright, c.bg_float, c.fg, c.border, c.bg_selection, c.fg_bright, c.fg,
    c.bg_selection, c.bg_cursorline, c.fg_dim, c.gold, c.bg, c.fg)
end

--- @return string
function M.hunk()
  local c = palette.colors
  return ([[
# Sora theme for Hunk (https://github.com/modem-dev/hunk).
# Install: copy into ~/.config/hunk/config.toml, or if you already keep a
# config, merge the [custom_theme] block below and set `theme = "custom"`.

theme = "custom"

[custom_theme]
base  = "github-dark-default"  # unset keys inherit from this built-in theme
label = "Sora"

background = "%s"
panel      = "%s"
panelAlt   = "%s"
border     = "%s"
accent     = "%s"
accentMuted = "%s"
text       = "%s"
muted      = "%s"

addedBg          = "%s"
removedBg        = "%s"
movedAddedBg     = "%s"
movedRemovedBg   = "%s"
contextBg        = "%s"
addedContentBg   = "%s"
removedContentBg = "%s"
contextContentBg = "%s"
addedSignColor   = "%s"
removedSignColor = "%s"

lineNumberBg = "%s"
lineNumberFg = "%s"
selectedHunk = "%s"

badgeAdded   = "%s"
badgeRemoved = "%s"
badgeNeutral = "%s"

fileNew       = "%s"
fileDeleted   = "%s"
fileRenamed   = "%s"
fileModified  = "%s"
fileUntracked = "%s"

noteBorder          = "%s"
noteBackground      = "%s"
noteTitleBackground = "%s"
noteTitleText       = "%s"

[custom_theme.syntax]
default     = "%s"
keyword     = "%s"
string      = "%s"
comment     = "%s"
number      = "%s"
function    = "%s"
property    = "%s"
type        = "%s"
variable    = "%s"
operator    = "%s"
punctuation = "%s"
]]):format(c.bg, c.bg_float, c.bg_elevated, c.border, c.accent, c.steel, c.fg,
    c.fg_dim, c.diff_add_bg, c.diff_delete_bg, c.diff_moved_add,
    c.diff_moved_delete, c.bg, c.diff_add_word, c.diff_delete_word, c.bg,
    c.git_add, c.git_delete, c.bg_float, c.fg_gutter_active, c.bg_selection,
    c.git_add, c.git_delete, c.steel, c.git_add, c.git_delete, c.accent,
    c.git_change, c.teal, c.purple, c.bg_elevated, c.bg_selection, c.fg_bright,
    c.fg, c.purple, c.sage, c.fg_comment, c.gold, c.accent, c.steel, c.peach,
    c.variable, c.steel, c.fg_dim)
end

--- @return string
function M.herdr()
  local c = palette.colors
  return ([[
# Sora theme for herdr (https://herdr.dev).
# Install: copy into ~/.config/herdr/config.toml, or merge the [theme] and
# [theme.custom] blocks below into your existing config.

[theme]
name = "terminal"   # neutral base; every palette token is overridden below by Sora
auto_switch = false

[theme.custom]
accent      = "%s"
panel_bg    = "%s"
surface0    = "%s"
surface1    = "%s"
surface_dim = "%s"
overlay0    = "%s"
overlay1    = "%s"
text        = "%s"
subtext0    = "%s"
mauve       = "%s"
green       = "%s"
yellow      = "%s"
red         = "%s"
blue        = "%s"
teal        = "%s"
peach       = "%s"
]]):format(c.accent, c.bg, c.bg_elevated, c.bg_cursorline, c.bg_float,
    c.fg_comment, c.steel, c.fg, c.fg_dim, c.purple, c.sage, c.gold, c.rose,
    c.git_change, c.teal, c.peach)
end

return M
