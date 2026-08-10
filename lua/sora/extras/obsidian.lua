local M = {}

-- The Obsidian theme. Obsidian's registry points at a repository, never at a
-- path inside one, and every theme keeps theme.css at its root. So unlike Zed,
-- which reads this repository directly, Obsidian needs a second repository, and
-- that copy is pushed by .github/workflows/sync-obsidian.yml rather than kept
-- in step by hand.

local palette = require("sora.palette")

local THEME = [==[
/* Sora — Obsidian Theme
 * Ethereal cyan, cool silver, deep OLED blacks.
 * https://github.com/Aejkatappaja/sora
 */

.theme-dark {
  /* ── Backgrounds ── */
  --background-primary:           @bg@;
  --background-primary-alt:       @bg_elevated@;
  --background-secondary:         @bg_float@;
  --background-secondary-alt:     @bg_elevated@;
  --background-modifier-border:   @border@;
  --background-modifier-form-field: @bg_elevated@;
  --background-modifier-form-field-highlighted: @bg_cursorline@;
  --background-modifier-box-shadow: rgba(0, 0, 0, 0.3);
  --background-modifier-success:  @git_add@;
  --background-modifier-error:    @error@;
  --background-modifier-error-rgb: 196, 108, 120;
  --background-modifier-error-hover: @terminal_bright_red@;
  --background-modifier-cover:    rgba(10, 12, 18, 0.8);

  /* ── Text ── */
  --text-normal:                  @fg@;
  --text-muted:                   @operator@;
  --text-faint:                   @fg_comment@;
  --text-on-accent:               @bg@;
  --text-on-accent-inverted:      @fg@;
  --text-error:                   @error@;
  --text-error-hover:             @terminal_bright_red@;
  --text-accent:                  @accent@;
  --text-accent-hover:            @terminal_bright_blue@;
  --text-selection:               rgba(30, 36, 48, 0.99);
  --text-highlight-bg:            rgba(212, 184, 120, 0.15);
  --text-highlight-bg-active:     rgba(212, 184, 120, 0.25);

  /* ── Interactive ── */
  --interactive-normal:           @bg_elevated@;
  --interactive-hover:            @bg_cursorline@;
  --interactive-accent:           @accent@;
  --interactive-accent-hsl:       197, 56%, 69%;
  --interactive-accent-hover:     @terminal_bright_blue@;
  --interactive-before:           @border@;

  /* ── Scrollbar ── */
  --scrollbar-bg:                 @bg@;
  --scrollbar-thumb-bg:           rgba(88, 100, 120, 0.3);
  --scrollbar-active-thumb-bg:    rgba(88, 100, 120, 0.5);

  /* ── Tabs ── */
  --tab-text-color:               @operator@;
  --tab-text-color-focused:       @fg@;
  --tab-text-color-focused-active: @accent@;
  --tab-text-color-focused-active-current: @fg@;
  --tab-background-active:        @bg@;
  --tab-outline-color:            @border@;
  --tab-divider-color:            @border@;

  /* ── Title bar ── */
  --titlebar-background:          @bg_float@;
  --titlebar-background-focused:  @bg_float@;
  --titlebar-text-color:          @operator@;
  --titlebar-text-color-focused:  @fg@;
  --titlebar-text-weight:         600;

  /* ── Nav / Sidebar ── */
  --nav-item-color:               @fg_dim@;
  --nav-item-color-hover:         @fg@;
  --nav-item-color-active:        @accent@;
  --nav-item-background-hover:    @bg_cursorline@;
  --nav-item-background-active:   @bg_selection@;
  --nav-heading-color:            @fg@;
  --nav-heading-color-collapsed:  @operator@;
  --nav-indentation-guide-color:  @border@;

  /* ── Headings ── */
  --h1-color:                     @accent@;
  --h2-color:                     @keyword@;
  --h3-color:                     @sage@;
  --h4-color:                     @peach@;
  --h5-color:                     @constant@;
  --h6-color:                     @operator@;

  /* ── Tags ── */
  --tag-color:                    @regex@;
  --tag-color-hover:              @terminal_bright_cyan@;
  --tag-background:               rgba(120, 184, 176, 0.1);
  --tag-background-hover:         rgba(120, 184, 176, 0.2);
  --tag-border-color:             rgba(120, 184, 176, 0.2);
  --tag-border-color-hover:       rgba(120, 184, 176, 0.3);

  /* ── Links ── */
  --link-color:                   @accent@;
  --link-color-hover:             @terminal_bright_blue@;
  --link-decoration:              none;
  --link-decoration-hover:        underline;
  --link-external-color:          @keyword@;
  --link-external-color-hover:    @terminal_bright_magenta@;
  --link-unresolved-color:        @rose@;
  --link-unresolved-opacity:      0.8;

  /* ── Code ── */
  --code-normal:                  @fg@;
  --code-comment:                 @fg_comment@;
  --code-function:                @accent@;
  --code-keyword:                 @keyword@;
  --code-string:                  @sage@;
  --code-tag:                     @regex@;
  --code-value:                   @constant@;
  --code-property:                @operator@;
  --code-important:               @rose@;
  --code-background:              @bg_float@;
  --code-size:                    0.925em;

  /* ── Inline code ── */
  --inline-code-color:            @peach@;
  --inline-code-background:       rgba(20, 22, 30, 0.8);

  /* ── Blockquote ── */
  --blockquote-border-color:      @accent@;
  --blockquote-border-thickness:  2px;
  --blockquote-background-color:  rgba(128, 200, 224, 0.03);

  /* ── Callouts ── */
  --callout-default:              @accent@;
  --callout-info:                 @info@;
  --callout-todo:                 @accent@;
  --callout-tip:                  @regex@;
  --callout-success:              @git_add@;
  --callout-question:             @constant@;
  --callout-warning:              @warning@;
  --callout-fail:                 @error@;
  --callout-error:                @error@;
  --callout-bug:                  @rose@;
  --callout-example:              @keyword@;
  --callout-quote:                @operator@;

  /* ── Checkbox ── */
  --checkbox-color:               @accent@;
  --checkbox-color-hover:         @terminal_bright_blue@;
  --checkbox-border-color:        @fg_gutter@;
  --checkbox-border-color-hover:  @accent@;

  /* ── Toggle ── */
  --toggle-thumb-color:           @fg@;
  --toggle-border-width:          1px;

  /* ── Slider ── */
  --slider-thumb-border-color:    @accent@;

  /* ── Table ── */
  --table-header-background:      @bg_elevated@;
  --table-header-background-hover: @bg_cursorline@;
  --table-row-alt-background:     rgba(20, 22, 30, 0.5);
  --table-border-color:           @border@;

  /* ── Flashing (search highlight) ── */
  --flashing-background:          rgba(212, 184, 120, 0.25);

  /* ── Status bar ── */
  --status-bar-background:        @bg_float@;
  --status-bar-border-color:      @border@;
  --status-bar-text-color:        @fg_comment@;

  /* ── Vault ── */
  --vault-name-color:             @accent@;
  --vault-name-font-size:         14px;

  /* ── Ribbon ── */
  --ribbon-background:            @bg_float@;
  --ribbon-background-collapsed:  @bg_float@;

  /* ── Divider ── */
  --divider-color:                @border@;
  --divider-color-hover:          @fg_gutter@;

  /* ── Icon ── */
  --icon-color:                   @operator@;
  --icon-color-hover:             @fg@;
  --icon-color-active:            @accent@;
  --icon-color-focused:           @accent@;

  /* ── Prompt (modals / command palette) ── */
  --prompt-border-color:          @border@;

  /* ── Bold / Italic ── */
  --bold-color:                   @fg_bright@;
  --italic-color:                 @keyword@;

  /* ── List markers ── */
  --list-marker-color:            @fg_comment@;
  --list-marker-color-hover:      @operator@;
  --list-marker-color-collapsed:  @accent@;

  /* ── Indentation guides ── */
  --indentation-guide-color:      @guide@;
  --indentation-guide-color-active: @guide_active@;

  /* ── Color accents (settings) ── */
  --color-accent:                 @accent@;
  --color-accent-1:               @accent@;
  --color-accent-2:               @keyword@;

  /* ── Graph ── */
  --graph-line:                   rgba(34, 40, 56, 0.6);
  --graph-node:                   @accent@;
  --graph-node-focused:           @terminal_bright_blue@;
  --graph-node-tag:               @regex@;
  --graph-node-attachment:        @constant@;
  --graph-node-unresolved:        @fg_comment@;
}

/* ── Accent color override for community ── */
.theme-dark {
  --accent-h: 197;
  --accent-s: 56%;
  --accent-l: 69%;
}

/* ── Styled scrollbar ── */
.theme-dark ::-webkit-scrollbar {
  width: 6px;
}

.theme-dark ::-webkit-scrollbar-track {
  background: transparent;
}

.theme-dark ::-webkit-scrollbar-thumb {
  background: rgba(88, 100, 120, 0.3);
  border-radius: 3px;
}

.theme-dark ::-webkit-scrollbar-thumb:hover {
  background: rgba(88, 100, 120, 0.5);
}

/* ── CodeMirror syntax highlighting (edit mode) ── */
.theme-dark .cm-s-obsidian .cm-keyword,
.theme-dark .cm-keyword {
  color: @keyword@ !important;
}

.theme-dark .cm-s-obsidian .cm-def,
.theme-dark .cm-s-obsidian .cm-callee,
.theme-dark .cm-def,
.theme-dark .cm-callee {
  color: @accent@ !important;
}

.theme-dark .cm-s-obsidian .cm-string,
.theme-dark .cm-s-obsidian .cm-string-2,
.theme-dark .cm-string,
.theme-dark .cm-string-2 {
  color: @sage@ !important;
}

.theme-dark .cm-s-obsidian .cm-number,
.theme-dark .cm-number {
  color: @constant@ !important;
}

.theme-dark .cm-s-obsidian .cm-variable,
.theme-dark .cm-s-obsidian .cm-variable-2,
.theme-dark .cm-s-obsidian .cm-variable-3,
.theme-dark .cm-variable,
.theme-dark .cm-variable-2,
.theme-dark .cm-variable-3 {
  color: @variable@ !important;
}

.theme-dark .cm-s-obsidian .cm-type,
.theme-dark .cm-type {
  color: @peach@ !important;
}

.theme-dark .cm-s-obsidian .cm-property,
.theme-dark .cm-s-obsidian .cm-qualifier,
.theme-dark .cm-property,
.theme-dark .cm-qualifier {
  color: @operator@ !important;
}

.theme-dark .cm-s-obsidian .cm-operator,
.theme-dark .cm-operator {
  color: @operator@ !important;
}

.theme-dark .cm-s-obsidian .cm-comment,
.theme-dark .cm-comment {
  color: @fg_comment@ !important;
}

.theme-dark .cm-s-obsidian .cm-atom,
.theme-dark .cm-s-obsidian .cm-builtin,
.theme-dark .cm-atom,
.theme-dark .cm-builtin {
  color: @rose@ !important;
}

.theme-dark .cm-s-obsidian .cm-tag,
.theme-dark .cm-tag {
  color: @regex@ !important;
}

.theme-dark .cm-s-obsidian .cm-attribute,
.theme-dark .cm-attribute {
  color: @peach@ !important;
}

.theme-dark .cm-s-obsidian .cm-meta,
.theme-dark .cm-meta {
  color: @regex@ !important;
}

.theme-dark .cm-s-obsidian .cm-punctuation,
.theme-dark .cm-punctuation {
  color: @fg_dim@ !important;
}

/* ── Prism.js syntax highlighting (reading mode) ── */
.theme-dark pre[class*="language-"] {
  background: @bg_float@ !important;
}

.theme-dark code[class*="language-"],
.theme-dark pre[class*="language-"] {
  color: @fg@;
}

.theme-dark .token.keyword,
.theme-dark .token.control,
.theme-dark .token.directive {
  color: @keyword@ !important;
}

.theme-dark .token.function,
.theme-dark .token.function-name {
  color: @accent@ !important;
}

.theme-dark .token.string,
.theme-dark .token.char,
.theme-dark .token.template-string {
  color: @sage@ !important;
}

.theme-dark .token.number,
.theme-dark .token.constant {
  color: @constant@ !important;
}

.theme-dark .token.variable {
  color: @variable@ !important;
}

.theme-dark .token.class-name,
.theme-dark .token.type {
  color: @peach@ !important;
}

.theme-dark .token.property {
  color: @operator@ !important;
}

.theme-dark .token.operator,
.theme-dark .token.arrow {
  color: @operator@ !important;
}

.theme-dark .token.comment,
.theme-dark .token.prolog,
.theme-dark .token.doctype,
.theme-dark .token.cdata {
  color: @fg_comment@ !important;
}

.theme-dark .token.boolean,
.theme-dark .token.builtin,
.theme-dark .token.important {
  color: @rose@ !important;
}

.theme-dark .token.tag {
  color: @regex@ !important;
}

.theme-dark .token.attr-name {
  color: @peach@ !important;
}

.theme-dark .token.attr-value {
  color: @sage@ !important;
}

.theme-dark .token.regex {
  color: @regex@ !important;
}

.theme-dark .token.punctuation {
  color: @fg_dim@ !important;
}]==]

--- @return string
function M.theme()
  local c = palette.colors

  local vars = {
    accent = c.accent,
    bg = c.bg,
    bg_cursorline = c.bg_cursorline,
    bg_elevated = c.bg_elevated,
    bg_float = c.bg_float,
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
    guide = c.guide,
    guide_active = c.guide_active,
    info = c.info,
    keyword = c.keyword,
    operator = c.operator,
    peach = c.peach,
    regex = c.regex,
    rose = c.rose,
    sage = c.sage,
    terminal_bright_blue = c.terminal_bright_blue,
    terminal_bright_cyan = c.terminal_bright_cyan,
    terminal_bright_magenta = c.terminal_bright_magenta,
    terminal_bright_red = c.terminal_bright_red,
    variable = c.variable,
    warning = c.warning,
  }

  return (THEME:gsub("@([%w_]+)@", vars))
end

--- The version is a placeholder. The sync workflow stamps the released one from
--- .release-please-manifest.json, so the committed file never carries a number
--- that a release pull request would move under the drift check.
--- @return string
function M.manifest()
  return [[
{
  "name": "Sora",
  "version": "0.0.0",
  "minAppVersion": "1.0.0",
  "author": "aejkatappaja",
  "authorUrl": "https://github.com/Aejkatappaja"
}
]]
end

return M
