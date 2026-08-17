local M = {}

-- The Zed extension. Zed reads it out of this repository through the `path`
-- field of its registry entry, so there is no copy to keep in step, unlike the
-- Obsidian theme. `id` and the theme name are the identity users have in their
-- settings: they do not move when the file does.

local palette = require("sora.palette")

local THEME = [==[
{
  "$schema": "https://zed.dev/schema/themes/v0.2.0.json",
  "name": "Sora",
  "author": "aejkatappaja",
  "themes": [
    {
      "name": "Sora",
      "appearance": "dark",
      "style": {
        "background": "@bg@",
        "border": "@border@",
        "border.variant": "@bg_selection@",
        "border.focused": "@accent@",
        "border.selected": "@accent@",
        "border.transparent": "#00000000",
        "border.disabled": "@border@",

        "elevated_surface.background": "@bg_elevated@",
        "surface.background": "@bg_float@",
        "background.appearance": "opaque",

        "element.background": "@bg_elevated@",
        "element.hover": "@bg_selection@",
        "element.active": "@bg_selection@",
        "element.selected": "@bg_selection@",
        "element.disabled": "@bg_elevated@",

        "drop_target.background": "#1e243080",

        "ghost_element.background": "#00000000",
        "ghost_element.hover": "@bg_selection@",
        "ghost_element.active": "@bg_selection@",
        "ghost_element.selected": "@bg_selection@",
        "ghost_element.disabled": "@bg_elevated@",

        "text": "@fg@",
        "text.muted": "@fg_dim@",
        "text.placeholder": "@fg_comment@",
        "text.disabled": "@fg_gutter@",
        "text.accent": "@accent@",

        "icon": "@fg@",
        "icon.muted": "@fg_dim@",
        "icon.disabled": "@fg_gutter@",
        "icon.placeholder": "@fg_comment@",
        "icon.accent": "@accent@",

        "status_bar.background": "@bg_float@",

        "title_bar.background": "@bg_float@",
        "title_bar.inactive_background": "@bg_float@",

        "toolbar.background": "@bg@",

        "tab_bar.background": "@bg_float@",
        "tab.inactive_background": "@bg_float@",
        "tab.active_background": "@bg@",

        "search.match_background": "@bg_search@",

        "panel.background": "@bg_float@",
        "panel.focused_border": "@accent@",

        "pane.focused_border": "@border@",

        "scrollbar.thumb.background": "#36405040",
        "scrollbar.thumb.hover_background": "#36405080",
        "scrollbar.thumb.border": "#00000000",
        "scrollbar.track.background": "#00000000",
        "scrollbar.track.border": "#00000000",

        "editor.background": "@bg@",
        "editor.foreground": "@fg@",
        "editor.gutter.background": "@bg@",
        "editor.subheader.background": "@bg_float@",
        "editor.active_line.background": "@bg_cursorline@",
        "editor.highlighted_line.background": "@bg_selection@",
        "editor.line_number": "@fg_gutter@",
        "editor.active_line_number": "@accent@",
        "editor.invisible": "@nontext@",
        "editor.wrap_guide": "@guide@",
        "editor.active_wrap_guide": "@guide_active@",
        "editor.indent_guide": "@guide@",
        "editor.indent_guide_active": "@guide_active@",
        "editor.document_highlight.read_background": "#1e243060",
        "editor.document_highlight.write_background": "#1e243090",

        "terminal.background": "@bg@",
        "terminal.foreground": "@fg@",
        "terminal.bright_foreground": "@fg_bright@",
        "terminal.dim_foreground": "@fg_dim@",
        "terminal.ansi.black": "@terminal_black@",
        "terminal.ansi.red": "@terminal_red@",
        "terminal.ansi.green": "@terminal_green@",
        "terminal.ansi.yellow": "@terminal_yellow@",
        "terminal.ansi.blue": "@terminal_blue@",
        "terminal.ansi.magenta": "@terminal_magenta@",
        "terminal.ansi.cyan": "@terminal_cyan@",
        "terminal.ansi.white": "@terminal_white@",
        "terminal.ansi.bright_black": "@terminal_bright_black@",
        "terminal.ansi.bright_red": "@terminal_bright_red@",
        "terminal.ansi.bright_green": "@terminal_bright_green@",
        "terminal.ansi.bright_yellow": "@terminal_bright_yellow@",
        "terminal.ansi.bright_blue": "@terminal_bright_blue@",
        "terminal.ansi.bright_magenta": "@terminal_bright_magenta@",
        "terminal.ansi.bright_cyan": "@terminal_bright_cyan@",
        "terminal.ansi.bright_white": "@terminal_bright_white@",
        "terminal.ansi.dim_black": "@bg_float@",
        "terminal.ansi.dim_red": "@terminal_dim_red@",
        "terminal.ansi.dim_green": "@terminal_dim_green@",
        "terminal.ansi.dim_yellow": "@terminal_dim_yellow@",
        "terminal.ansi.dim_blue": "@terminal_dim_blue@",
        "terminal.ansi.dim_magenta": "@terminal_dim_magenta@",
        "terminal.ansi.dim_cyan": "@terminal_dim_cyan@",
        "terminal.ansi.dim_white": "@fg_dim@",

        "link_text.hover": "@accent@",

        "conflict": "@constant@",
        "conflict.background": "#d4b87820",
        "conflict.border": "#d4b87840",

        "created": "@git_add@",
        "created.background": "#68b08020",
        "created.border": "#68b08040",

        "deleted": "@git_delete@",
        "deleted.background": "#b8606820",
        "deleted.border": "#b8606840",

        "error": "@error@",
        "error.background": "#c46c7820",
        "error.border": "#c46c7840",

        "hidden": "@fg_comment@",
        "hidden.background": "#58647820",
        "hidden.border": "#58647840",

        "hint": "@hint@",
        "hint.background": "#78b0a020",
        "hint.border": "#78b0a040",

        "ignored": "@fg_comment@",
        "ignored.background": "#58647820",
        "ignored.border": "#58647840",

        "info": "@info@",
        "info.background": "#5ca8c820",
        "info.border": "#5ca8c840",

        "modified": "@git_change@",
        "modified.background": "#6898b820",
        "modified.border": "#6898b840",

        "predictive": "@fg_comment@",
        "predictive.background": "#58647820",
        "predictive.border": "#58647840",

        "renamed": "@accent@",
        "renamed.background": "#80c8e020",
        "renamed.border": "#80c8e040",

        "success": "@ok@",
        "success.background": "#68a88820",
        "success.border": "#68a88840",

        "unreachable": "@fg_comment@",
        "unreachable.background": "#58647820",
        "unreachable.border": "#58647840",

        "warning": "@warning@",
        "warning.background": "#c8a86020",
        "warning.border": "#c8a86040",

        "players": [
          {
            "cursor": "@accent@",
            "background": "@accent@",
            "selection": "#80c8e030"
          },
          {
            "cursor": "@keyword@",
            "background": "@keyword@",
            "selection": "#b0a0d830"
          },
          {
            "cursor": "@sage@",
            "background": "@sage@",
            "selection": "#90c8a030"
          },
          {
            "cursor": "@constant@",
            "background": "@constant@",
            "selection": "#d4b87830"
          },
          {
            "cursor": "@peach@",
            "background": "@peach@",
            "selection": "#d0a88830"
          },
          {
            "cursor": "@rose@",
            "background": "@rose@",
            "selection": "#d0909c30"
          },
          {
            "cursor": "@regex@",
            "background": "@regex@",
            "selection": "#78b8b030"
          },
          {
            "cursor": "@operator@",
            "background": "@operator@",
            "selection": "#8898b830"
          }
        ],

        "syntax": {
          "attribute": {
            "color": "@peach@",
            "font_style": "italic"
          },
          "boolean": {
            "color": "@rose@",
            "font_style": "italic"
          },
          "comment": {
            "color": "@fg_comment@",
            "font_style": "italic"
          },
          "comment.doc": {
            "color": "@fg_comment@",
            "font_style": "italic"
          },
          "constant": {
            "color": "@constant@"
          },
          "constructor": {
            "color": "@peach@",
            "font_weight": 700
          },
          "embedded": {
            "color": "@regex@"
          },
          "emphasis": {
            "color": "@fg_bright@",
            "font_style": "italic"
          },
          "emphasis.strong": {
            "color": "@fg_bright@",
            "font_weight": 700
          },
          "enum": {
            "color": "@peach@"
          },
          "function": {
            "color": "@accent@"
          },
          "function.builtin": {
            "color": "@accent@",
            "font_style": "italic"
          },
          "function.method": {
            "color": "@accent@"
          },
          "hint": {
            "color": "@hint@"
          },
          "keyword": {
            "color": "@keyword@",
            "font_style": "italic"
          },
          "label": {
            "color": "@regex@"
          },
          "link_text": {
            "color": "@accent@"
          },
          "link_uri": {
            "color": "@accent@"
          },
          "number": {
            "color": "@constant@"
          },
          "operator": {
            "color": "@operator@"
          },
          "predictive": {
            "color": "@fg_comment@",
            "font_style": "italic"
          },
          "preproc": {
            "color": "@keyword@"
          },
          "primary": {
            "color": "@fg@"
          },
          "property": {
            "color": "@operator@"
          },
          "punctuation": {
            "color": "@fg_dim@"
          },
          "punctuation.bracket": {
            "color": "@fg_dim@"
          },
          "punctuation.delimiter": {
            "color": "@fg_dim@"
          },
          "punctuation.list_marker": {
            "color": "@operator@"
          },
          "punctuation.special": {
            "color": "@operator@"
          },
          "string": {
            "color": "@sage@"
          },
          "string.doc": {
            "color": "@sage@",
            "font_style": "italic"
          },
          "string.escape": {
            "color": "@regex@",
            "font_weight": 700
          },
          "string.regex": {
            "color": "@regex@"
          },
          "string.special": {
            "color": "@regex@"
          },
          "string.special.symbol": {
            "color": "@constant@"
          },
          "tag": {
            "color": "@regex@"
          },
          "tag.attribute": {
            "color": "@peach@"
          },
          "tag.delimiter": {
            "color": "@fg_dim@"
          },
          "text.literal": {
            "color": "@sage@"
          },
          "title": {
            "color": "@accent@",
            "font_weight": 700
          },
          "type": {
            "color": "@peach@"
          },
          "type.builtin": {
            "color": "@peach@",
            "font_style": "italic"
          },
          "variable": {
            "color": "@variable@"
          },
          "variable.builtin": {
            "color": "@rose@",
            "font_style": "italic"
          },
          "variable.member": {
            "color": "@operator@"
          },
          "variable.parameter": {
            "color": "@peach@"
          },
          "variable.special": {
            "color": "@rose@",
            "font_style": "italic"
          },
          "variant": {
            "color": "@peach@"
          }
        }
      }
    }
  ]
}
]==]

--- @return string
function M.theme()
  local c = palette.colors

  local vars = {
    accent = c.accent,
    bg = c.bg,
    bg_cursorline = c.bg_cursorline,
    bg_elevated = c.bg_elevated,
    bg_float = c.bg_float,
    bg_search = c.bg_search,
    bg_selection = c.bg_selection,
    border = c.border,
    constant = c.constant,
    error = c.error,
    fg = c.fg,
    fg_bright = c.fg_bright,
    fg_comment = c.fg_comment,
    fg_dim = c.fg_dim,
    fg_gutter = c.fg_gutter,
    git_add = c.git_add,
    git_change = c.git_change,
    git_delete = c.git_delete,
    guide = c.guide,
    guide_active = c.guide_active,
    hint = c.hint,
    info = c.info,
    keyword = c.keyword,
    nontext = c.nontext,
    ok = c.ok,
    operator = c.operator,
    peach = c.peach,
    regex = c.regex,
    rose = c.rose,
    sage = c.sage,
    terminal_black = c.terminal_black,
    terminal_blue = c.terminal_blue,
    terminal_bright_black = c.terminal_bright_black,
    terminal_bright_blue = c.terminal_bright_blue,
    terminal_bright_cyan = c.terminal_bright_cyan,
    terminal_bright_green = c.terminal_bright_green,
    terminal_bright_magenta = c.terminal_bright_magenta,
    terminal_bright_red = c.terminal_bright_red,
    terminal_bright_white = c.terminal_bright_white,
    terminal_bright_yellow = c.terminal_bright_yellow,
    terminal_cyan = c.terminal_cyan,
    terminal_dim_blue = c.terminal_dim_blue,
    terminal_dim_cyan = c.terminal_dim_cyan,
    terminal_dim_green = c.terminal_dim_green,
    terminal_dim_magenta = c.terminal_dim_magenta,
    terminal_dim_red = c.terminal_dim_red,
    terminal_dim_yellow = c.terminal_dim_yellow,
    terminal_green = c.terminal_green,
    terminal_magenta = c.terminal_magenta,
    terminal_red = c.terminal_red,
    terminal_white = c.terminal_white,
    terminal_yellow = c.terminal_yellow,
    variable = c.variable,
    warning = c.warning,
  }

  return (THEME:gsub("@([%w_]+)@", vars))
end

--- Zed reads the licence from inside the extension directory, so the repository
--- root copy is mirrored rather than kept in step by hand.
--- @return string
function M.licence()
  local fd = assert(io.open("LICENSE", "r"), "LICENSE is missing from the repository root")
  local body = fd:read("*a")
  fd:close()
  return body
end

--- The version is a literal on purpose. Reading it from
--- .release-please-manifest.json would make a release pull request bump the
--- manifest, re-render this file at the new number and fail the drift check on
--- every release. Same reason the Firefox manifest pins its own.
--- @return string
function M.extension()
  return [[
id = "sora-theme"
name = "Sora"
version = "0.1.2"
schema_version = 1
authors = ["aejkatappaja"]
description = "A dark theme inspired by the sky above. Ethereal cyan, cool silver, deep OLED blacks."
repository = "https://github.com/Aejkatappaja/sora"
]]
end

return M
