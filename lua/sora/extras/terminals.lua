local M = {}

-- Terminals. Every file here is rendered from lua/sora/palette.lua and nothing
-- else, so a colour cannot be right in the editor and stale in a terminal.

local palette = require("sora.palette")

--- The sixteen ANSI slots, in the order every terminal below writes them.
--- @param c table
--- @return string[]
local function ansi(c)
  return {
    c.terminal_black, c.terminal_red, c.terminal_green, c.terminal_yellow,
    c.terminal_blue, c.terminal_magenta, c.terminal_cyan, c.terminal_white,
    c.terminal_bright_black, c.terminal_bright_red, c.terminal_bright_green,
    c.terminal_bright_yellow, c.terminal_bright_blue, c.terminal_bright_magenta,
    c.terminal_bright_cyan, c.terminal_bright_white,
  }
end

--- @return string
function M.ghostty()
  local c = palette.colors
  local s = ansi(c)
  local slots = {}
  for i = 1, 8 do slots[i] = ("palette = %d=%s"):format(i - 1, s[i]) end
  local bright = {}
  for i = 9, 16 do bright[i - 8] = ("palette = %d=%s"):format(i - 1, s[i]) end

  return ([[
# Sora - the sky above
# https://github.com/aejkatappaja/sora.nvim

background = %s
foreground = %s
cursor-color = %s
cursor-text = %s
selection-foreground = %s
selection-background = %s

# Normal colors
%s

# Bright colors
%s
]]):format(c.bg, c.fg, c.accent, c.bg, c.fg_bright, c.bg_selection,
    table.concat(slots, "\n"), table.concat(bright, "\n"))
end

--- @return string
function M.kitty()
  local c = palette.colors
  local s = ansi(c)
  local normal, bright = {}, {}
  for i = 1, 8 do normal[i] = ("color%d %s"):format(i - 1, s[i]) end
  for i = 9, 16 do bright[i - 8] = ("color%d %s"):format(i - 1, s[i]) end

  return ([[
# Sora - https://github.com/aejkatappaja/sora.nvim

background %s
foreground %s
cursor %s
cursor_text_color %s
selection_background %s
selection_foreground %s
url_color %s
active_border_color %s
inactive_border_color %s
bell_border_color %s
active_tab_background %s
active_tab_foreground %s
inactive_tab_background %s
inactive_tab_foreground %s

# Normal
%s

# Bright
%s
]]):format(c.bg, c.fg, c.accent, c.bg, c.bg_selection, c.fg_bright,
    c.accent, c.accent, c.border, c.gold, c.bg, c.fg, c.bg_float, c.fg_comment,
    table.concat(normal, "\n"), table.concat(bright, "\n"))
end

--- @return string
function M.alacritty()
  local c = palette.colors
  local s = ansi(c)
  local names = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }
  local normal, bright = {}, {}
  for i = 1, 8 do normal[i] = ('%s = "%s"'):format(names[i], s[i]) end
  for i = 9, 16 do bright[i - 8] = ('%s = "%s"'):format(names[i - 8], s[i]) end

  return ([[
# Sora - https://github.com/aejkatappaja/sora.nvim

[colors.primary]
background = "%s"
foreground = "%s"

[colors.cursor]
cursor = "%s"
text = "%s"

[colors.vi_mode_cursor]
cursor = "%s"
text = "%s"

[colors.selection]
background = "%s"
text = "%s"

[colors.search.matches]
background = "%s"
foreground = "%s"

[colors.search.focused_match]
background = "%s"
foreground = "%s"

[colors.hints.start]
background = "%s"
foreground = "%s"

[colors.hints.end]
background = "%s"
foreground = "%s"

[colors.normal]
%s

[colors.bright]
%s
]]):format(c.bg, c.fg, c.accent, c.bg, c.purple, c.bg, c.bg_selection, c.fg_bright,
    c.bg_search, c.fg_bright, c.accent, c.bg, c.gold, c.bg, c.bg_elevated, c.gold,
    table.concat(normal, "\n"), table.concat(bright, "\n"))
end

--- @return string
function M.wezterm()
  local c = palette.colors
  local s = ansi(c)
  local normal, bright = {}, {}
  for i = 1, 8 do normal[i] = ('    "%s",'):format(s[i]) end
  for i = 9, 16 do bright[i - 8] = ('    "%s",'):format(s[i]) end

  return ([[
# Sora - https://github.com/aejkatappaja/sora.nvim

[colors]
background = "%s"
foreground = "%s"
cursor_bg = "%s"
cursor_fg = "%s"
cursor_border = "%s"
selection_bg = "%s"
selection_fg = "%s"
compose_cursor = "%s"
scrollbar_thumb = "%s"
split = "%s"

ansi = [
%s
]
brights = [
%s
]

[colors.tab_bar]
background = "%s"

[colors.tab_bar.active_tab]
bg_color = "%s"
fg_color = "%s"

[colors.tab_bar.inactive_tab]
bg_color = "%s"
fg_color = "%s"

[colors.tab_bar.inactive_tab_hover]
bg_color = "%s"
fg_color = "%s"

[colors.tab_bar.new_tab]
bg_color = "%s"
fg_color = "%s"

[colors.tab_bar.new_tab_hover]
bg_color = "%s"
fg_color = "%s"

[metadata]
name = "Sora"
author = "aejkatappaja"
]]):format(c.bg, c.fg, c.accent, c.bg, c.accent, c.bg_selection, c.fg_bright,
    c.gold, c.border, c.border,
    table.concat(normal, "\n"), table.concat(bright, "\n"),
    c.bg_float, c.bg, c.fg, c.bg_float, c.fg_comment, c.bg_elevated, c.fg_dim,
    c.bg_float, c.fg_comment, c.bg_elevated, c.fg_dim)
end

--- @return string
function M.foot()
  local c = palette.colors
  local s = ansi(c)
  --- foot writes its colours without the leading hash
  local function bare(hex) return (hex:gsub("^#", "")) end
  local regular, bright = {}, {}
  for i = 1, 8 do regular[i] = ("regular%d=%s"):format(i - 1, bare(s[i])) end
  for i = 9, 16 do bright[i - 8] = ("bright%d=%s"):format(i - 9, bare(s[i])) end

  return ([[
# Sora - https://github.com/aejkatappaja/sora.nvim

[colors]
cursor=%s %s
foreground=%s
background=%s

%s

%s

selection-foreground=%s
selection-background=%s

search-box-no-match=%s %s
search-box-match=%s %s

jump-labels=%s %s
urls=%s
]]):format(bare(c.bg), bare(c.accent), bare(c.fg), bare(c.bg),
    table.concat(regular, "\n"), table.concat(bright, "\n"),
    bare(c.fg_bright), bare(c.bg_selection),
    bare(c.bg), bare(c.error), bare(c.fg_bright), bare(c.bg_search),
    bare(c.bg), bare(c.gold), bare(c.accent))
end

--- @return string
function M.tmux()
  local c = palette.colors
  return ([[
# Sora theme for tmux
# source-file ~/.config/tmux/sora.tmux.conf

# Status bar
set -g status-style "bg=default fg=%s"
set -g status-position bottom
set -g status-justify left
set -g status-left-length 200

set -g status-left "#[fg=%s,bold] #{session_name}  "
set -g status-right "#[fg=%s]#(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD) "

# Window status
set -g window-status-format "#[fg=%s]#{window_index}:#{window_name}#{window_flags} "
set -g window-status-current-format "#[fg=%s,bold]#{window_index}:#{window_name}#{window_flags} "
set -g window-status-last-style "fg=%s"
set -g window-status-activity-style "fg=%s"

# Pane borders
set -g pane-border-style "fg=%s"
set -g pane-active-border-style "fg=%s"

# Messages
set -g message-style "bg=%s fg=%s"
set -g message-command-style "bg=%s fg=%s"

# Selection / copy mode
set -g mode-style "bg=%s fg=%s"
]]):format(c.fg, c.accent, c.fg_comment, c.fg_comment, c.accent, c.fg_dim, c.gold,
    c.border, c.accent, c.bg_elevated, c.fg, c.bg_elevated, c.fg,
    c.bg_selection, c.fg_bright)
end

--- The tokyo-night-tmux plugin paints its own statusbar with these keys and never
--- program output, so four of them are mapped by role rather than by ANSI name:
--- bblack is a block background, black and bwhite read as foregrounds.
--- @return string
function M.tokyo_night_tmux()
  local c = palette.colors
  return ([[
# Sora theme for tokyo-night-tmux plugin
# Paste this block into your tokyo-night-tmux themes.sh
# (before the default "night" case)
# Then add to tmux.conf: set -g @tokyo-night-tmux_theme "sora"

"sora")
  declare -A THEME=(
    ["background"]="%s"
    ["foreground"]="%s"
    ["black"]="%s"
    ["blue"]="%s"
    ["cyan"]="%s"
    ["green"]="%s"
    ["magenta"]="%s"
    ["red"]="%s"
    ["white"]="%s"
    ["yellow"]="%s"

    ["bblack"]="%s"
    ["bblue"]="%s"
    ["bcyan"]="%s"
    ["bgreen"]="%s"
    ["bmagenta"]="%s"
    ["bred"]="%s"
    ["bwhite"]="%s"
    ["byellow"]="%s"
  )
  ;;
]]):format(c.bg, c.fg, c.terminal_black, c.terminal_blue, c.terminal_cyan,
    c.terminal_green, c.terminal_magenta, c.terminal_red, c.terminal_white,
    c.terminal_yellow,
    c.bg_selection, c.terminal_bright_blue, c.terminal_bright_cyan, c.ok,
    c.terminal_bright_magenta, c.terminal_bright_red, c.fg_comment,
    c.terminal_bright_yellow)
end


-- Terminal.app stores each colour as an archived NSColor. The archive is a fixed
-- binary plist with one field of fixed width spliced in, so the offset table
-- never moves: a template, not a plist writer. Ported from cendre, where it was
-- verified by decoding the result back through a plist parser.

local ARCHIVE_PREFIX = "bplist\048\048\212\001\002\003\004\005\006\021" ..
  "\024Y$archiverX$obj" ..
  "ectsT$topX$versi" ..
  "on_\016\015NSKeyedArch" ..
  "iver\163\007\008\015U$null\211\009" ..
  "\010\011\012\013\014V$class\092NSC" ..
  "olorSpaceUNSRGB\128" ..
  "\002\016\001O\016$"

local ARCHIVE_SUFFIX = "\000\210\016\017\018\019X$classesZ" ..
  "$classname\162\019\020WNS" ..
  "ColorXNSObject\209\022" ..
  "\023Troot\128\001\018\000\001\134\160\008\017\027" ..
  "$\041\050DHNU\092ioqs\154\159\168\179" ..
  "\182\190\199\202\207\209\000\000\000\000\000\000\001\001\000\000" ..
  "\000\000\000\000\000\025\000\000\000\000\000\000\000\000\000\000" ..
  "\000\000\000\000\000\214"

local B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

--- @param data string raw bytes
--- @return string base64
local function base64(data)
  local out = {}
  for i = 1, #data, 3 do
    local a, b, c = data:byte(i, i + 2)
    local n = a * 65536 + (b or 0) * 256 + (c or 0)
    local chunk = {
      B64:sub(math.floor(n / 262144) % 64 + 1, math.floor(n / 262144) % 64 + 1),
      B64:sub(math.floor(n / 4096) % 64 + 1, math.floor(n / 4096) % 64 + 1),
      b and B64:sub(math.floor(n / 64) % 64 + 1, math.floor(n / 64) % 64 + 1) or "=",
      c and B64:sub(n % 64 + 1, n % 64 + 1) or "=",
    }
    table.insert(out, table.concat(chunk))
  end
  return table.concat(out)
end

--- One archived NSColor, wrapped at 68 characters the way Terminal.app writes it.
--- @param hex string
--- @return string
local function archived(hex)
  local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)$")
  local rgb = ("%.9f %.9f %.9f"):format(
    tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255)
  assert(#rgb == 35, "rgb field changed width, the template no longer applies")

  local encoded = base64(ARCHIVE_PREFIX .. rgb .. ARCHIVE_SUFFIX)
  local lines = {}
  for i = 1, #encoded, 68 do
    table.insert(lines, "\t" .. encoded:sub(i, i + 67))
  end
  return table.concat(lines, "\n")
end

--- Terminal.app writes its keys in alphabetical order, so this does too: the file
--- is meant to be diffable against one the application saved itself.
--- @return string
function M.macos_terminal()
  local c = palette.colors
  local s = ansi(c)

  local entries = {
    { "ANSIBlackColor", s[1] }, { "ANSIBlueColor", s[5] },
    { "ANSIBrightBlackColor", s[9] }, { "ANSIBrightBlueColor", s[13] },
    { "ANSIBrightCyanColor", s[15] }, { "ANSIBrightGreenColor", s[11] },
    { "ANSIBrightMagentaColor", s[14] }, { "ANSIBrightRedColor", s[10] },
    { "ANSIBrightWhiteColor", s[16] }, { "ANSIBrightYellowColor", s[12] },
    { "ANSICyanColor", s[7] }, { "ANSIGreenColor", s[3] },
    { "ANSIMagentaColor", s[6] }, { "ANSIRedColor", s[2] },
    { "ANSIWhiteColor", s[8] }, { "ANSIYellowColor", s[4] },
    { "BackgroundColor", c.bg }, { "BoldTextColor", c.fg_bright },
    { "CursorColor", c.accent },
  }

  local body = {}
  for _, e in ipairs(entries) do
    table.insert(body, ("\t<key>%s</key>\n\t<data>\n%s\n\t</data>"):format(e[1], archived(e[2])))
  end

  return ([[
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
%s
	<key>ProfileCurrentVersion</key>
	<real>2.04</real>
	<key>SelectionColor</key>
	<data>
%s
	</data>
	<key>TextColor</key>
	<data>
%s
	</data>
	<key>name</key>
	<string>Sora</string>
	<key>type</key>
	<string>Window Settings</string>
</dict>
</plist>
]]):format(table.concat(body, "\n"), archived(c.bg_selection), archived(c.fg))
end

--- @return string
function M.itermcolors()
  local c = palette.colors
  local s = ansi(c)

  --- @param hex string
  --- @param key string
  --- @return string
  local function colour(hex, key)
    local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)$")
    return ([[
	<key>%s</key>
	<dict>
		<key>Red Component</key><real>%.6f</real>
		<key>Green Component</key><real>%.6f</real>
		<key>Blue Component</key><real>%.6f</real>
	</dict>]]):format(key,
      tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255)
  end

  local body = {}
  for i, hex in ipairs(s) do
    table.insert(body, colour(hex, ("Ansi %d Color"):format(i - 1)))
  end
  vim.list_extend(body, {
    colour(c.bg, "Background Color"),
    colour(c.fg, "Foreground Color"),
    colour(c.fg_bright, "Bold Color"),
    colour(c.accent, "Cursor Color"),
    colour(c.bg_selection, "Selection Color"),
  })

  return ([[
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
%s
</dict>
</plist>
]]):format(table.concat(body, "\n"))
end

return M
