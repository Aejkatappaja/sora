local M = {}

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

[custom_theme.syntax_scopes]
"source" = "%s"
"comment" = "%s"
"punctuation.definition.comment" = "%s"
"keyword" = "%s"
"keyword.control" = "%s"
"storage" = "%s"
"storage.type" = "%s"
"storage.modifier" = "%s"
"keyword.operator" = "%s"
"punctuation" = "%s"
"string" = "%s"
"constant.numeric" = "%s"
"constant.language" = "%s"
"entity.name.function" = "%s"
"support.function" = "%s"
"variable.function" = "%s"
"entity.name.type" = "%s"
"entity.name.class" = "%s"
"support.type" = "%s"
"support.class" = "%s"
"variable" = "%s"
"variable.other.constant" = "%s"
"variable.other.property" = "%s"
"support.variable.property" = "%s"
"variable.parameter" = "%s"
]]):format(c.bg, c.bg_float, c.bg_elevated, c.border, c.accent, c.steel, c.fg,
    c.fg_dim, c.diff_add_bg, c.diff_delete_bg, c.diff_moved_add,
    c.diff_moved_delete, c.bg, c.diff_add_word, c.diff_delete_word, c.bg,
    c.git_add, c.git_delete, c.bg_float, c.fg_gutter_active, c.bg_selection,
    c.git_add, c.git_delete, c.steel, c.git_add, c.git_delete, c.accent,
    c.git_change, c.teal, c.purple, c.bg_elevated, c.bg_selection, c.fg_bright,
    c.fg, c.purple, c.sage, c.fg_comment, c.gold, c.accent, c.steel, c.peach,
    c.variable, c.steel, c.fg_dim,
    c.fg, c.fg_comment, c.fg_comment, c.keyword, c.keyword, c.keyword,
    c.keyword, c.keyword, c.operator, c.fg_dim, c.string, c.gold, c.gold,
    c.func, c.func, c.func, c.type, c.type, c.type, c.type, c.variable,
    c.variable, c.steel, c.steel, c.peach)
end

--- Section and key names come from yazi's own preset theme, not from its docs.
--- It renamed [manager] to [mgr] and [select] to [pick], and moved the tab, mode
--- and hovered keys out into [tabs], [mode] and [indicator]. An unknown section
--- is ignored rather than refused, so the retired spelling applied nothing and
--- said nothing.
--- @return string
function M.yazi()
  local c = palette.colors

  --- @param t table
  --- @return string
  local function style(t)
    local parts = {}
    if t.fg then parts[#parts + 1] = ('fg = "%s"'):format(t.fg) end
    if t.bg then parts[#parts + 1] = ('bg = "%s"'):format(t.bg) end
    if t.bold then parts[#parts + 1] = "bold = true" end
    if t.italic then parts[#parts + 1] = "italic = true" end
    return "{ " .. table.concat(parts, ", ") .. " }"
  end

  local sections = {
    { "mgr", {
      { "cwd", { fg = c.accent } },
      { "find_keyword", { fg = c.gold, bold = true } },
      { "find_position", { fg = c.accent, italic = true } },
      { "symlink_target", { fg = c.fg_comment, italic = true } },
      { "marker_copied", { fg = c.sage, bg = c.sage } },
      { "marker_cut", { fg = c.error, bg = c.error } },
      { "marker_marked", { fg = c.purple, bg = c.purple } },
      { "marker_selected", { fg = c.accent, bg = c.accent } },
      { "count_copied", { fg = c.bg, bg = c.sage } },
      { "count_cut", { fg = c.bg, bg = c.error } },
      { "count_selected", { fg = c.bg, bg = c.accent } },
      { "border_style", { fg = c.border } },
    } },
    { "tabs", {
      { "active", { fg = c.fg, bg = c.bg_elevated } },
      { "inactive", { fg = c.fg_comment, bg = c.bg_float } },
    } },
    { "mode", {
      { "normal_main", { fg = c.bg, bg = c.accent, bold = true } },
      { "normal_alt", { fg = c.accent, bg = c.bg_elevated } },
      { "select_main", { fg = c.bg, bg = c.purple, bold = true } },
      { "select_alt", { fg = c.purple, bg = c.bg_elevated } },
      { "unset_main", { fg = c.bg, bg = c.rose, bold = true } },
      { "unset_alt", { fg = c.rose, bg = c.bg_elevated } },
    } },
    { "indicator", {
      { "parent", { bg = c.bg_elevated } },
      { "current", { bg = c.bg_selection } },
      { "preview", { bg = c.bg_elevated } },
    } },
    { "status", {
      { "overall", { fg = c.fg, bg = c.bg_elevated } },
      { "perm_sep", { fg = c.fg_gutter } },
      { "perm_type", { fg = c.teal } },
      { "perm_read", { fg = c.gold } },
      { "perm_write", { fg = c.rose } },
      { "perm_exec", { fg = c.sage } },
      { "progress_label", { fg = c.fg, bold = true } },
      { "progress_normal", { fg = c.accent, bg = c.bg_elevated } },
      { "progress_error", { fg = c.bg, bg = c.error } },
    } },
    { "which", {
      { "mask", { bg = c.bg_float } },
      { "cand", { fg = c.accent } },
      { "rest", { fg = c.fg_comment } },
      { "desc", { fg = c.fg_dim } },
      { "separator_style", { fg = c.border } },
    } },
    { "confirm", {
      { "border", { fg = c.accent } },
      { "title", { fg = c.accent } },
      { "body", { fg = c.fg } },
      { "list", { fg = c.fg_dim } },
      { "btn_yes", { fg = c.bg, bg = c.accent, bold = true } },
      { "btn_no", { fg = c.fg_dim } },
    } },
    { "spot", {
      { "border", { fg = c.accent } },
      { "title", { fg = c.accent } },
      { "tbl_col", { fg = c.teal } },
      { "tbl_cell", { fg = c.bg, bg = c.accent } },
    } },
    { "notify", {
      { "title_info", { fg = c.info } },
      { "title_warn", { fg = c.warning } },
      { "title_error", { fg = c.error } },
    } },
    { "pick", {
      { "border", { fg = c.accent } },
      { "active", { fg = c.accent, bold = true } },
      { "inactive", { fg = c.fg_dim } },
    } },
    { "input", {
      { "border", { fg = c.accent } },
      { "title", { fg = c.accent } },
      { "value", { fg = c.fg } },
      { "selected", { bg = c.bg_selection } },
    } },
    { "cmp", {
      { "border", { fg = c.accent } },
      { "active", { fg = c.bg, bg = c.accent } },
      { "inactive", { fg = c.fg_dim } },
    } },
    { "tasks", {
      { "border", { fg = c.accent } },
      { "title", { fg = c.accent } },
      { "hovered", { fg = c.accent, bold = true } },
    } },
    { "help", {
      { "on", { fg = c.accent } },
      { "run", { fg = c.fg_dim } },
      { "desc", { fg = c.fg_comment } },
      { "hovered", { bg = c.bg_selection, bold = true } },
      { "footer", { fg = c.fg_comment, bg = c.bg_float } },
    } },
  }

  local rules = {
    { 'mime = "image/*"', c.peach }, { 'mime = "video/*"', c.gold },
    { 'mime = "audio/*"', c.gold }, { 'mime = "application/zip"', c.purple },
    { 'mime = "application/gzip"', c.purple },
    { 'mime = "application/x-tar"', c.purple },
    { 'mime = "application/x-bzip2"', c.purple },
    { 'mime = "application/x-7z-compressed"', c.purple },
    { 'mime = "application/x-rar"', c.purple },
    { 'url = "*.rs"', c.peach }, { 'url = "*.lua"', c.accent },
    { 'url = "*.ts"', c.accent }, { 'url = "*.js"', c.gold },
    { 'url = "*.py"', c.sage }, { 'url = "*.go"', c.teal },
    { 'url = "*.md"', c.fg_dim }, { 'url = "*.json"', c.gold },
    { 'url = "*.toml"', c.peach }, { 'url = "*.yaml"', c.rose },
    { 'url = "*.yml"', c.rose },
  }

  local out = {
    "# Sora theme for Yazi",
    "# https://github.com/aejkatappaja/sora.nvim",
  }
  for _, section in ipairs(sections) do
    out[#out + 1] = ""
    out[#out + 1] = ("[%s]"):format(section[1])
    for _, kv in ipairs(section[2]) do
      out[#out + 1] = ("%s = %s"):format(kv[1], style(kv[2]))
    end
  end

  out[#out + 1] = ""
  out[#out + 1] = "[filetype]"
  out[#out + 1] = "rules = ["
  for _, r in ipairs(rules) do
    out[#out + 1] = ('  { %s, fg = "%s" },'):format(r[1], r[2])
  end
  out[#out + 1] = "]"

  return table.concat(out, "\n") .. "\n"
end

--- Every value under "theme" names a def above it. A literal would resolve to
--- nothing and opencode would throw at load rather than at review.
--- @return string
function M.opencode()
  local c = palette.colors
  return ([[
{
  "$schema": "https://opencode.ai/theme.json",
  "defs": {
    "bg": "%s",
    "bgFloat": "%s",
    "bgElevated": "%s",
    "bgCursorline": "%s",
    "bgSelection": "%s",
    "bgSearch": "%s",
    "fg": "%s",
    "fgDim": "%s",
    "fgBright": "%s",
    "fgComment": "%s",
    "fgGutter": "%s",
    "border": "%s",
    "cyan": "%s",
    "purple": "%s",
    "sage": "%s",
    "rose": "%s",
    "gold": "%s",
    "peach": "%s",
    "teal": "%s",
    "steel": "%s",
    "variable": "%s",
    "error": "%s",
    "warning": "%s",
    "success": "%s",
    "info": "%s",
    "gitAdd": "%s",
    "gitDelete": "%s",
    "gitChange": "%s",
    "diffAddBg": "%s",
    "diffDeleteBg": "%s",
    "diffChangeBg": "%s"
  },
  "theme": {
    "primary": "cyan",
    "secondary": "purple",
    "accent": "gold",

    "error": "error",
    "warning": "warning",
    "success": "success",
    "info": "info",

    "text": "fg",
    "textMuted": "fgDim",
    "selectedListItemText": "fgBright",

    "background": "bg",
    "backgroundPanel": "bgFloat",
    "backgroundElement": "bgElevated",
    "backgroundMenu": "bgFloat",

    "border": "border",
    "borderActive": "cyan",
    "borderSubtle": "border",

    "diffAdded": "gitAdd",
    "diffRemoved": "gitDelete",
    "diffContext": "fgDim",
    "diffHunkHeader": "purple",
    "diffHighlightAdded": "sage",
    "diffHighlightRemoved": "rose",
    "diffAddedBg": "diffAddBg",
    "diffRemovedBg": "diffDeleteBg",
    "diffContextBg": "bg",
    "diffLineNumber": "fgGutter",
    "diffAddedLineNumberBg": "diffAddBg",
    "diffRemovedLineNumberBg": "diffDeleteBg",

    "markdownText": "fg",
    "markdownHeading": "cyan",
    "markdownLink": "cyan",
    "markdownLinkText": "cyan",
    "markdownCode": "sage",
    "markdownBlockQuote": "fgDim",
    "markdownEmph": "fgBright",
    "markdownStrong": "fgBright",
    "markdownHorizontalRule": "border",
    "markdownListItem": "steel",
    "markdownListEnumeration": "steel",
    "markdownImage": "cyan",
    "markdownImageText": "cyan",
    "markdownCodeBlock": "sage",

    "syntaxComment": "fgComment",
    "syntaxKeyword": "purple",
    "syntaxFunction": "cyan",
    "syntaxVariable": "variable",
    "syntaxString": "sage",
    "syntaxNumber": "gold",
    "syntaxType": "peach",
    "syntaxOperator": "steel",
    "syntaxPunctuation": "fgDim"
  }
}
]]):format(c.bg, c.bg_float, c.bg_elevated, c.bg_cursorline, c.bg_selection,
    c.bg_search, c.fg, c.fg_dim, c.fg_bright, c.fg_comment, c.fg_gutter,
    c.border, c.cyan, c.purple, c.sage, c.rose, c.gold, c.peach, c.teal,
    c.steel, c.variable, c.error, c.warning, c.ok, c.info, c.git_add,
    c.git_delete, c.git_change, c.diff_add_bg, c.diff_delete_bg, c.diff_change_bg)
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

--- @return string
function M.bat()
  local c = palette.colors

  -- A TextMate theme. bat matches on scope selectors rather than on highlight
  -- groups, so a rule can only be as precise as the scopes its syntaxes emit:
  -- several roles that lua/sora/groups separates collapse onto one selector here.

  --- The editor chrome, in the order Sublime writes it.
  local globals = {
    { "background", c.bg },
    { "foreground", c.fg },
    { "caret", c.accent },
    { "selection", c.bg_selection },
    { "selectionForeground", c.fg_bright },
    { "lineHighlight", c.bg_cursorline },
    { "invisibles", c.nontext },
    { "gutter", c.bg },
    { "gutterForeground", c.fg_gutter },
    { "findHighlight", c.bg_search },
    { "findHighlightForeground", c.fg_bright },
    { "guide", c.guide },
    { "activeGuide", c.guide_active },
    { "stackGuide", c.guide },
  }

  --- section comment, rule name, scope selector, foreground, fontStyle.
  --- A nil fontStyle omits the key; "" writes it empty, which is how a rule
  --- cancels a style inherited from a broader selector.
  local rules = {
    { "Comments", "Comment", "comment, punctuation.definition.comment", c.fg_comment, "italic" },
    { "Strings", "String", "string, punctuation.definition.string", c.string },
    { "String escape", "String Escape", "constant.character.escape, string.regexp", c.regex, "bold" },
    { "Numbers", "Number", "constant.numeric", c.gold },
    { "Constants", "Constant", "constant, constant.language, constant.other", c.constant },
    { "Boolean", "Boolean", "constant.language.boolean", c.rose, "italic" },
    { "Variables", "Variable", "variable, variable.other", c.variable },
    { "Built-in variables", "Variable Built-in", "variable.language", c.rose, "italic" },
    { "Parameters", "Parameter", "variable.parameter", c.peach },
    {
      "Object properties / members",
      "Member",
      "variable.other.member, variable.other.property, variable.other.object.property",
      c.steel,
    },
    { "Keywords", "Keyword", "keyword, keyword.control, keyword.other, storage.modifier", c.keyword, "italic" },
    { "Keyword operator", "Keyword Operator", "keyword.operator", c.operator, "" },
    {
      "Operators",
      "Operator",
      "punctuation.accessor, keyword.operator.assignment, keyword.operator.arithmetic, "
        .. "keyword.operator.logical, keyword.operator.bitwise, keyword.operator.comparison",
      c.operator,
    },
    { "Storage / keyword.function", "Storage", "storage, storage.type", c.keyword, "italic" },
    { "Functions", "Function", "entity.name.function, support.function, meta.function-call", c.func },
    { "Built-in functions", "Function Built-in", "support.function.builtin", c.func, "italic" },
    { "Macros", "Macro", "entity.name.function.macro, support.function.macro", c.teal, "bold" },
    {
      "Types",
      "Type",
      "entity.name.type, entity.name.class, entity.name.struct, entity.name.enum, entity.name.union, "
        .. "entity.name.trait, entity.name.interface, support.type, support.class",
      c.type,
    },
    {
      "Built-in types",
      "Type Built-in",
      "support.type.builtin, storage.type.built-in, storage.type.primitive",
      c.type,
      "italic",
    },
    {
      "Constructors",
      "Constructor",
      "entity.name.function.constructor, meta.method.constructor",
      c.type,
      "bold",
    },
    {
      "Preprocessor / Include",
      "Preprocessor",
      "keyword.control.import, keyword.control.include, keyword.control.from, meta.preprocessor",
      c.keyword,
      "italic",
    },
    { "Tags (HTML/XML)", "Tag", "entity.name.tag", c.tag },
    { "Tag attributes", "Tag Attribute", "entity.other.attribute-name", c.peach },
    { "Tag delimiters", "Tag Delimiter", "punctuation.definition.tag", c.fg_dim },
    {
      "Punctuation / Delimiters",
      "Punctuation",
      "punctuation.separator, punctuation.terminator, punctuation.section",
      c.fg_dim,
    },
    {
      "Brackets",
      "Bracket",
      "punctuation.section.brackets, punctuation.section.parens, punctuation.section.braces, "
        .. "punctuation.section.block, punctuation.section.group",
      c.fg_dim,
    },
    {
      "Annotations / Attributes / Decorators",
      "Annotation",
      "meta.annotation, variable.annotation, punctuation.definition.annotation",
      c.peach,
    },
    { "Labels", "Label", "entity.name.label", c.teal },
    {
      "Modules / Namespaces",
      "Module",
      "entity.name.namespace, entity.name.module, support.other.module",
      c.fg_dim,
    },
    {
      "Exceptions",
      "Exception",
      "keyword.control.exception, keyword.control.trycatch, support.type.exception",
      c.rose,
    },
    {
      "Special / SpecialComment",
      "Special Comment",
      "comment.line.documentation, comment.block.documentation",
      c.fg_comment,
      "italic",
    },
    { "Markup headings", "Markup Heading", "markup.heading, punctuation.definition.heading", c.accent, "bold" },
    { "Markup bold", "Markup Bold", "markup.bold", c.fg_bright, "bold" },
    { "Markup italic", "Markup Italic", "markup.italic", c.fg_bright, "italic" },
    { "Markup link", "Markup Link", "markup.underline.link, string.other.link", c.accent, "underline" },
    { "Markup raw / code", "Markup Code", "markup.raw, markup.inline.raw", c.sage },
    { "Markup quote", "Markup Quote", "markup.quote", c.fg_dim, "italic" },
    { "Markup list", "Markup List", "markup.list, punctuation.definition.list", c.steel },
    { "Diff added", "Diff Added", "markup.inserted, meta.diff.header.to-file", c.git_add },
    { "Diff deleted", "Diff Deleted", "markup.deleted, meta.diff.header.from-file", c.git_delete },
    { "Diff changed", "Diff Changed", "markup.changed", c.git_change },
    { "Invalid", "Invalid", "invalid, invalid.illegal", c.error },
    { "Deprecated", "Deprecated", "invalid.deprecated", c.rose, "italic" },
  }

  local blocks = {
    [[<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>name</key>
  <string>Sora</string>
  <key>semanticClass</key>
  <string>theme.dark.sora</string>
  <key>author</key>
  <string>aejkatappaja</string>
  <key>uuid</key>
  <string>8A7844DC-8F22-4EC3-B288-CF514D5F3409</string>
  <key>colorSpaceName</key>
  <string>sRGB</string>
  <key>settings</key>
  <array>]],
  }

  local settings = {}
  for _, kv in ipairs(globals) do
    settings[#settings + 1] = ("        <key>%s</key>\n        <string>%s</string>"):format(kv[1], kv[2])
  end
  blocks[#blocks + 1] = ([[
    <!-- Global settings -->
    <dict>
      <key>settings</key>
      <dict>
%s
      </dict>
    </dict>]]):format(table.concat(settings, "\n"))

  for _, r in ipairs(rules) do
    local section, name, scope, fg, style = r[1], r[2], r[3], r[4], r[5]
    local body = ("        <key>foreground</key>\n        <string>%s</string>"):format(fg)
    if style then
      body = body .. ("\n        <key>fontStyle</key>\n        <string>%s</string>"):format(style)
    end
    blocks[#blocks + 1] = ([[
    <!-- %s -->
    <dict>
      <key>name</key>
      <string>%s</string>
      <key>scope</key>
      <string>%s</string>
      <key>settings</key>
      <dict>
%s
      </dict>
    </dict>]]):format(section, name, scope, body)
  end

  blocks[#blocks + 1] = [[
  </array>
</dict>
</plist>]]

  return table.concat(blocks, "\n\n") .. "\n"
end

return M
