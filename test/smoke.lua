-- Smoke test for the Sora colorscheme.
-- Run: nvim --headless --noplugin -u NONE -c "set rtp+=." -c "luafile test/smoke.lua"
-- Exits non-zero on failure (via :cquit) so CI catches it.

local failures = {}

-- setup() merges into the live config, so options set by one check survive into
-- the next. Anything that asserts on an option needs a clean module first.
local function reload()
  package.loaded["sora"] = nil
  return require("sora")
end

local function check(name, fn)
  local ok, err = pcall(fn)
  if ok then
    print("ok   - " .. name)
  else
    print("FAIL - " .. name .. ": " .. tostring(err))
    table.insert(failures, name)
  end
end

-- load() applies every highlight via nvim_set_hl, which throws on a nil or
-- malformed color. So a clean load is the core regression guard: any group
-- referencing a missing palette key blows up here.
check("default setup + load", function()
  require("sora").setup()
  require("sora").load()
  assert(vim.g.colors_name == "sora", "colors_name not set")
end)

check("transparent = true", function()
  require("sora").setup({ transparent = true })
  require("sora").load()
  assert(vim.api.nvim_get_hl(0, { name = "Normal" }).bg == nil, "Normal bg not stripped")
end)

check("italic = false", function()
  require("sora").setup({ italic = false })
  require("sora").load()
  assert(not vim.api.nvim_get_hl(0, { name = "Comment" }).italic, "Comment still italic")
end)

check("on_colors override", function()
  require("sora").setup({
    on_colors = function(colors) colors.bg = "#000000" end,
  })
  require("sora").load()
end)

check("on_highlights override", function()
  require("sora").setup({
    on_highlights = function(hl, colors) hl.Normal = { fg = colors.fg, bg = "#000000" } end,
  })
  require("sora").load()
  assert(vim.api.nvim_get_hl(0, { name = "Normal" }).bg == 0x000000, "override not applied")
end)

-- A group that copies NormalFloat or FloatBorder renders identically and buys
-- nothing, because every plugin already points its windows at those two. What it
-- does buy is a pinned colour that `transparent = true` cannot strip, which is
-- what used to leave Telescope, Trouble and Noice opaque over the terminal.
-- Colour the two surfaces, and the windows follow.
check("no group repeats a float surface, so plugin windows can inherit it", function()
  local c = require("sora.palette").colors
  local built = {}
  for _, mod in ipairs({ "editor", "syntax", "treesitter", "lsp", "integrations" }) do
    for name, hl in pairs(require("sora.groups." .. mod).get(c)) do built[name] = hl end
  end

  local function signature(hl)
    local parts = {}
    for _, key in ipairs({ "fg", "bg", "sp", "bold", "italic", "underline", "reverse", "link" }) do
      if hl[key] ~= nil then parts[#parts + 1] = key .. "=" .. tostring(hl[key]) end
    end
    return table.concat(parts, " ")
  end

  local surfaces = { NormalFloat = true, FloatBorder = true }
  local function allowed(name)
    -- The completion menu stays painted on purpose, borders included: a
    -- see-through popup over code is not readable.
    if name:match("^Pmenu") then return true end
    -- blink.cmp points its windows at its own groups rather than at the float
    -- surfaces, so they cannot inherit and have to pin a colour.
    if name:match("^BlinkCmp") then return true end
    -- Names bg_statusline, which is the same hex as bg_float. It owns its ground
    -- rather than inheriting one, and is stripped by name under transparent.
    return name == "StatusLine"
  end

  for name, hl in pairs(built) do
    if not surfaces[name] and not allowed(name) then
      for surface in pairs(surfaces) do
        assert(signature(hl) ~= signature(built[surface]),
          name .. " is a verbatim copy of " .. surface
          .. ", which pins a colour transparent = true then cannot strip")
      end
    end
  end
end)

check("transparent = true leaves no window surface painted", function()
  local sora = reload()
  sora.setup({ transparent = true })
  sora.load()

  local c = require("sora.palette").colors
  local grounds = {}
  for _, key in ipairs({ "bg", "bg_float", "bg_elevated" }) do
    grounds[tonumber(c[key]:sub(2), 16)] = key
  end

  -- Anything a plugin points a window at ends in one of these. A ground surviving
  -- here means the reader asked to see their terminal and got a panel instead.
  for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
    if hl.bg and grounds[hl.bg] and not name:match("^BlinkCmp") and not name:match("^Pmenu")
      and (name:match("Normal$") or name:match("NormalNC$") or name:match("Float$")
      or name:match("Border$") or name:match("Popup$")
      -- mini.nvim spells it Tabline, Neovim spells it TabLine
      or name:match("[Tt]ab[Ll]ine")) then
      error(name .. " still paints " .. grounds[hl.bg] .. " under transparent = true")
    end
  end
end)

check("transparent = true keeps the strokes that draw an edge", function()
  local sora = reload()
  sora.setup({ transparent = true })
  sora.load()

  -- Stripped, not dropped: a transparent float with no border has no edge, and a
  -- transparent split with no separator has no seam.
  for _, name in ipairs({ "FloatBorder", "WinSeparator" }) do
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    assert(hl.bg == nil, name .. " keeps a background under transparent = true")
    assert(hl.fg ~= nil, name .. " lost its stroke under transparent = true")
  end
end)

check("lualine theme loads", function()
  local theme = require("lualine.themes.sora")
  assert(theme.normal and theme.normal.a, "lualine theme malformed")
end)

if #failures > 0 then
  print(("\n%d test(s) failed"):format(#failures))
  vim.cmd("cquit 1")
else
  print("\nall tests passed")
  vim.cmd("quitall")
end
