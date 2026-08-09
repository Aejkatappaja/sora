local M = {}

-- Every file listed here is rendered from lua/sora/palette.lua and nothing else,
-- so a colour cannot be right in the editor and stale in a terminal.
--
-- This module only builds strings. scripts/extras.lua writes them to disk, and
-- test/extras.lua compares them against what is committed, which is what makes
-- hand-editing a generated file a test failure instead of a silent divergence.
--
-- Surfaces not listed yet are still maintained by hand. They are covered by the
-- palette membership check in the same test, which is weaker: it catches a colour
-- that left the palette, not a file nobody remembered to update.

local terminals = require("sora.extras.terminals")
local tools = require("sora.extras.tools")

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
}

--- Every generated file, keyed by path relative to the repo root.
--- @return table<string, string>
function M.files()
  local out = {}
  for path, build in pairs(FILES) do out[path] = build() end
  return out
end

return M
