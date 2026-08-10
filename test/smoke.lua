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

check("no group Neovim ships keeps a colour the palette does not define", function()
  local sora = reload()
  sora.setup()
  sora.load()

  local known = {}
  for _, v in pairs(require("sora.palette").colors) do
    if type(v) == "string" and v:match("^#%x%x%x%x%x%x$") then known[v:lower()] = true end
  end

  -- The internal error and the redraw debug surfaces keep Neovim's own colours:
  -- they have to stay readable when the theme is the bug.
  local checked = 0
  for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
    if name ~= "NvimInternalError" and not name:match("^RedrawDebug") then
      for _, key in ipairs({ "fg", "bg", "sp" }) do
        if type(hl[key]) == "number" then
          checked = checked + 1
          assert(known[("#%06x"):format(hl[key])],
            ("%s sets %s to #%06x, which the palette does not define"):format(name, key, hl[key]))
        end
      end
    end
  end
  assert(checked > 300, "only " .. checked .. " colours checked, expected hundreds")
end)

-- The next three read a tool's own source rather than its documentation page.
-- Every one of these tools ignores what it does not recognise instead of
-- refusing it, so half a theme applies and nothing says which half. The drift
-- check cannot see it: regenerating only makes the file agree with itself.

check("the opencode theme fills every colour its Theme type declares", function()
  local body = require("sora.extras").files()["extras/opencode/sora.json"]
  assert(body, "missing extras/opencode/sora.json")

  -- Every RGBA field of the Theme type in opencode's tui package. Its ThemeJson
  -- requires all but two, and those two fall back rather than fail, so a gap is
  -- invisible: the selected row's text silently becomes the background and the
  -- menu silently becomes backgroundElement. The published docs list neither.
  local slots = {
    "primary", "secondary", "accent", "error", "warning", "success", "info",
    "text", "textMuted", "selectedListItemText", "background", "backgroundPanel",
    "backgroundElement", "backgroundMenu", "border", "borderActive", "borderSubtle",
    "diffAdded", "diffRemoved", "diffContext", "diffHunkHeader",
    "diffHighlightAdded", "diffHighlightRemoved", "diffAddedBg", "diffRemovedBg",
    "diffContextBg", "diffLineNumber", "diffAddedLineNumberBg",
    "diffRemovedLineNumberBg", "markdownText", "markdownHeading", "markdownLink",
    "markdownLinkText", "markdownCode", "markdownBlockQuote", "markdownEmph",
    "markdownStrong", "markdownHorizontalRule", "markdownListItem",
    "markdownListEnumeration", "markdownImage", "markdownImageText",
    "markdownCodeBlock", "syntaxComment", "syntaxKeyword", "syntaxFunction",
    "syntaxVariable", "syntaxString", "syntaxNumber", "syntaxType",
    "syntaxOperator", "syntaxPunctuation",
  }

  local defs, named = {}, {}
  for name in body:match('"defs": {(.-)\n  }'):gmatch('"([%w]+)":') do defs[name] = true end
  for name, ref in body:match('"theme": {(.-)\n  }'):gmatch('"([%w]+)": "([^"]+)"') do
    named[name] = true
    -- A literal would resolve to nothing, and opencode throws at load rather
    -- than at review.
    assert(defs[ref], "opencode points " .. name .. " at " .. ref .. ", which is not a def")
  end

  for _, slot in ipairs(slots) do
    assert(named[slot], "opencode leaves " .. slot .. " to its own fallback")
  end

  assert(body:match('"diffAddedBg": "([^"]+)"') ~= body:match('"diffRemovedBg": "([^"]+)"'),
    "opencode gives added and removed rows the same ground")
end)

check("the hunk theme fills every slot hunk reads, and none it does not", function()
  local body = require("sora.extras").files()["extras/hunk/sora.toml"]
  assert(body, "missing extras/hunk/sora.toml")

  -- CUSTOM_THEME_COLOR_KEYS in hunk's config parser. The parser iterates that
  -- constant, so anything else is dropped without a word.
  local slots = {
    "background", "panel", "panelAlt", "border", "accent", "accentMuted", "text",
    "muted", "addedBg", "removedBg", "movedAddedBg", "movedRemovedBg", "contextBg",
    "addedContentBg", "removedContentBg", "contextContentBg", "addedSignColor",
    "removedSignColor", "lineNumberBg", "lineNumberFg", "selectedHunk",
    "badgeAdded", "badgeRemoved", "badgeNeutral", "fileNew", "fileDeleted",
    "fileRenamed", "fileModified", "fileUntracked", "noteBorder", "noteBackground",
    "noteTitleBackground", "noteTitleText",
  }
  for _, slot in ipairs(slots) do
    assert(body:find("\n" .. slot .. " ", 1, true) or body:find("\n" .. slot .. "=", 1, true),
      "hunk leaves " .. slot .. " to the base theme")
  end

  -- Four names that only look like keys. Matched with the trailing space the
  -- alignment gives them, so addedBg and removedBg do not answer for them.
  for _, name in ipairs({ "\nadded ", "\nremoved ", "\ncontext ", "\nlineNumber " }) do
    assert(not body:find(name, 1, true),
      "hunk writes " .. name:gsub("%s", "") .. ", which it never reads")
  end

  -- Both tables, which is the migration shape hunk documents: the released
  -- version reads only the roles, its successor prefers the scopes.
  assert(body:find("[custom_theme.syntax]", 1, true), "hunk theme has no role table")
  assert(body:find("[custom_theme.syntax_scopes]", 1, true), "hunk theme has no scope table")
end)

check("the yazi theme uses section and key names yazi still knows", function()
  local body = require("sora.extras").files()["extras/yazi/sora.toml"]
  assert(body, "missing extras/yazi/sora.toml")

  -- Taken from yazi's own preset theme. It renamed [manager] to [mgr] and
  -- [select] to [pick], and moved the tab, mode and hovered keys out into
  -- [tabs], [mode] and [indicator].
  local sections = {
    flavor = true, app = true, mgr = true, tabs = true, mode = true,
    indicator = true, status = true, which = true, confirm = true, spot = true,
    notify = true, pick = true, input = true, cmp = true, tasks = true,
    help = true, filetype = true,
  }
  -- Only names retired everywhere. `hovered` is not among them: it left [mgr]
  -- but is still a key of [tasks] and [help]. preview_hovered covers that case.
  local retired = {
    "%[manager%]", "%[select%]", "preview_hovered",
    "tab_active", "tab_inactive", "mode_normal", "mode_select", "mode_unset",
    "separator_open", "separator_close",
  }

  local seen = 0
  for name in body:gmatch("\n%[([a-z]+)%]") do
    assert(sections[name], "yazi theme writes [" .. name .. "], which yazi does not read")
    seen = seen + 1
  end
  assert(seen >= 15, "yazi theme covers only " .. seen .. " sections")

  for _, pattern in ipairs(retired) do
    assert(not body:find(pattern),
      "yazi theme still writes " .. pattern:gsub("%%", "") .. ", which yazi retired")
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
