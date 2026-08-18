local M = {}

-- Every file listed here is rendered from lua/sora/palette.lua and nothing else,
-- so a colour cannot be right in the editor and stale in a terminal.
--
-- This module only builds strings. scripts/extras.lua writes them to disk, and
-- test/extras.lua compares them against what is committed, which is what makes
-- hand-editing a generated file a test failure instead of a silent divergence.
--
-- The list is every surface under extras/. Adding one means adding a builder
-- here, not a file there.

local terminals = require("sora.extras.terminals")
local tools = require("sora.extras.tools")
local editors = require("sora.extras.editors")
local firefox_start = require("sora.extras.firefox_start")
local zed = require("sora.extras.zed")
local obsidian = require("sora.extras.obsidian")
local yaak = require("sora.extras.yaak")

--- @type table<string, fun(): string>
local FILES = {
  ["extras/ghostty/sora"] = terminals.ghostty,
  ["extras/kitty/sora.conf"] = terminals.kitty,
  ["extras/alacritty/sora.toml"] = terminals.alacritty,
  ["extras/wezterm/sora.toml"] = terminals.wezterm,
  ["extras/foot/sora.ini"] = terminals.foot,
  ["extras/tmux/sora.tmux.conf"] = terminals.tmux,
  ["extras/tmux/tokyo-night-tmux-sora.sh"] = terminals.tokyo_night_tmux,
  ["extras/macos-terminal/sora.itermcolors"] = terminals.itermcolors,
  ["extras/macos-terminal/sora.terminal"] = terminals.macos_terminal,

  ["extras/fzf/sora.sh"] = tools.fzf,
  ["extras/delta/sora.gitconfig"] = tools.delta,
  ["extras/lazygit/sora.yml"] = tools.lazygit,
  ["extras/herdr/sora.toml"] = tools.herdr,
  ["extras/eza/sora.sh"] = tools.eza,
  ["extras/slack/sora.txt"] = tools.slack,
  ["extras/starship/sora.toml"] = tools.starship,
  ["extras/btop/sora.theme"] = tools.btop,
  ["extras/firefox/manifest.json"] = tools.firefox,
  ["extras/hunk/sora.toml"] = tools.hunk,
  ["extras/yazi/sora.toml"] = tools.yazi,
  ["extras/opencode/sora.json"] = tools.opencode,
  ["extras/bat/sora.tmTheme"] = tools.bat,

  ["extras/firefox-start/index.html"] = firefox_start.index,

  ["extras/zed/themes/sora.json"] = zed.theme,
  ["extras/zed/extension.toml"] = zed.extension,
  ["extras/zed/LICENSE"] = zed.licence,

  ["extras/yaak/src/index.ts"] = yaak.theme,
  ["extras/yaak/package.json"] = yaak.package_json,
  ["extras/yaak/tsconfig.json"] = yaak.tsconfig,

  ["extras/obsidian/sora/theme.css"] = obsidian.theme,
  ["extras/obsidian/sora/manifest.json"] = obsidian.manifest,

  ["extras/vim/sora.vim"] = editors.vim,
  ["extras/helix/sora.toml"] = editors.helix,
}

--- Every generated file, keyed by path relative to the repo root.
--- @return table<string, string>
function M.files()
  local out = {}
  for path, build in pairs(FILES) do out[path] = build() end
  return out
end

return M
