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

local function luminance(hex)
  local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)$")
  local function lin(v)
    v = v / 255
    return v <= 0.04045 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
  end
  return 0.2126 * lin(tonumber(r, 16)) + 0.7152 * lin(tonumber(g, 16)) + 0.0722 * lin(tonumber(b, 16))
end

local function ratio(a, b)
  local la, lb = luminance(a), luminance(b)
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05)
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

local SYNTAX = {
  "cyan", "purple", "sage", "rose", "gold", "peach", "teal", "steel", "variable",
}
local DIAGNOSTIC = { "error", "warning", "info", "hint", "ok" }

check("one role, one hue: no two syntax colours share a hex", function()
  local c = require("sora.palette").colors
  local seen = {}
  for _, name in ipairs(SYNTAX) do
    local hex = c[name]
    assert(not seen[hex], name .. " and " .. tostring(seen[hex]) .. " are both " .. hex)
    seen[hex] = name
  end
end)

check("no syntax colour collides with a diagnostic", function()
  local c = require("sora.palette").colors
  for _, d in ipairs(DIAGNOSTIC) do
    for _, s in ipairs(SYNTAX) do
      assert(c[d] ~= c[s], d .. " and " .. s .. " are the same colour, so a state reads as a token")
    end
  end
end)

check("the role map holds: every token lands on the colour the palette names", function()
  local sora = reload()
  sora.setup()
  sora.load()
  local c = require("sora.palette").colors

  -- The map lua/sora/palette.lua documents beside each colour. A group that
  -- ignores it will look wrong beside every other group, and the extras render
  -- from the same roles, so a drift here reaches the terminal too.
  local map = {
    ["@keyword"] = "keyword", ["@keyword.function"] = "keyword",
    ["@function"] = "func", ["@function.call"] = "func",
    ["@string"] = "string", ["@string.regex"] = "string",
    ["@number"] = "constant", ["@constant"] = "constant",
    ["@boolean"] = "rose",
    ["@type"] = "type", ["@constructor"] = "type", ["@variable.parameter"] = "type",
    ["@variable"] = "variable", ["@property"] = "variable",
    ["@operator"] = "operator",
    ["@tag"] = "tag", ["@character.special"] = "tag",
    ["@comment"] = "fg_comment",
  }

  for group, role in pairs(map) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    assert(hl.fg, group .. " has no foreground")
    local got = ("#%06x"):format(hl.fg)
    assert(got == c[role],
      ("%s is %s, but the map puts it on %s (%s)"):format(group, got, role, c[role]))
  end
end)

check("the palette the README prints is the palette the module ships", function()
  local fd = assert(io.open("README.md", "r"))
  local body = fd:read("*a")
  fd:close()
  local c = require("sora.palette").colors

  local rows = {
    Background = "bg", Foreground = "fg", Cyan = "cyan", Purple = "purple",
    Sage = "sage", Peach = "peach", Gold = "gold", Rose = "rose",
    Teal = "teal", Steel = "steel",
  }

  local seen = 0
  for label, swatch, hex in body:gmatch("|%s*%**([%a]+)%**%s*|%s*!%[%]%(([^%)]+)%)%s*|%s*`(#%x%x%x%x%x%x)`") do
    local role = rows[label]
    if role then
      seen = seen + 1
      assert(hex == c[role],
        ("the README prints %s for %s, the module ships %s"):format(hex, label, c[role]))
      -- The swatch is the same hex twice in a placehold.co URL, so a row can go
      -- stale in the picture while the code beside it stays right.
      local bare = hex:sub(2)
      local _, count = swatch:gsub(bare, "")
      assert(count == 2, "the " .. label .. " swatch does not paint " .. hex)
    end
  end
  assert(seen == 10, "the README palette table has " .. seen .. " of 10 known rows")
end)

-- No ratio is published, so this fixes a floor rather than a number. The three
-- exceptions carry their measured value: a change that makes one worse fails
-- here instead of shipping.
check("nothing readable goes under 4.5:1, and the three that do are named", function()
  local c = require("sora.palette").colors
  local grounds = { "bg", "bg_float", "bg_elevated" }

  local exempt = {
    -- meant to recede, and the only text that is
    fg_comment = 3.0,
    -- line numbers and signs, decoration rather than prose
    fg_gutter = 1.7,
    -- 4.44:1 over bg. Named rather than nudged, because the hue is published
    git_delete = 4.2,
  }

  local readable = { "fg", "fg_bright", "fg_dim", "variable", "git_add", "git_change" }
  for _, name in ipairs(SYNTAX) do readable[#readable + 1] = name end
  for _, name in ipairs(DIAGNOSTIC) do readable[#readable + 1] = name end
  for name in pairs(exempt) do readable[#readable + 1] = name end

  for _, name in ipairs(readable) do
    local worst = math.huge
    for _, ground in ipairs(grounds) do
      worst = math.min(worst, ratio(c[name], c[ground]))
    end
    local floor = exempt[name] or 4.5
    assert(worst >= floor,
      ("%s is %.2f:1 at worst, under the %.2f it is held to"):format(name, worst, floor))
    if exempt[name] then
      assert(worst < 4.5,
        name .. " now clears 4.5:1, so drop it from the exceptions rather than keep the excuse")
    end
  end
end)

check("nothing conveys meaning through style alone", function()
  local sora = reload()
  sora.setup()
  sora.load()

  -- Bold, Italic and the markup underline are a style and nothing else: that is
  -- the whole group. Everything else that leans on weight has to carry a colour
  -- too, or it says nothing to a reader whose font has one face.
  local style_only = { Bold = true, Italic = true, ["@markup.underline"] = true }

  for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
    if not style_only[name] and not name:match("^RedrawDebug") then
      local styled = hl.bold or hl.italic or hl.underline or hl.undercurl or hl.reverse
      if styled and not hl.link then
        assert(hl.fg or hl.bg or hl.sp,
          name .. " carries a style and no colour, so it reads as nothing")
      end
    end
  end
end)

local function slurp(path)
  local fd = assert(io.open(path, "r"), "cannot read " .. path)
  local body = fd:read("*a")
  fd:close()
  return body
end

check("transparent = false keeps every ground painted", function()
  local sora = reload()
  sora.setup({ transparent = false })
  sora.load()
  for _, name in ipairs({ "Normal", "NormalFloat", "StatusLine", "Pmenu" }) do
    assert(vim.api.nvim_get_hl(0, { name = name }).bg, name .. " has no background by default")
  end
end)

check("every float edge is the same stroke", function()
  local sora = reload()
  sora.setup()
  sora.load()

  -- A window edge is chrome, so it is one colour everywhere. The notification
  -- borders are the exception and the reason is the point: there the colour is
  -- the severity, not the frame.
  local want = ("#%06x"):format(vim.api.nvim_get_hl(0, { name = "FloatBorder" }).fg)
  for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
    if name:match("Border$") and hl.fg and not name:match("^Notify") then
      assert(("#%06x"):format(hl.fg) == want,
        name .. " draws its edge in #" .. ("%06x"):format(hl.fg) .. ", not " .. want)
    end
  end
end)

check("the landing page carries the same palette as the module", function()
  local body = slurp("docs/index.html")
  local c = require("sora.palette").colors

  local seen = 0
  -- [%w_], not %w: Lua leaves the underscore out, which would skip every
  -- bg_float and git_add row in the table and check only the short names.
  for key, hex in body:gmatch('%["([%w_]+)",%s*"(#%x%x%x%x%x%x)"') do
    if c[key] then
      seen = seen + 1
      assert(hex:lower() == c[key]:lower(),
        ("the page prints %s for %s, the module ships %s"):format(hex, key, c[key]))
    end
  end
  assert(seen >= 20, "the page palette table has only " .. seen .. " rows the module knows")
end)

check("every path the landing page tells a reader to copy exists", function()
  local body = slurp("docs/index.html")
  local seen = 0
  for path in body:gmatch("extras/[%w%._%-/]+") do
    seen = seen + 1
    assert(vim.uv.fs_stat(path), "the page points at " .. path .. ", which is not in the repo")
  end
  assert(seen >= 15, "the page names only " .. seen .. " paths under extras/")
end)

check("the surface count the landing page prints is what extras ships", function()
  local body = slurp("docs/index.html")
  local claimed = tonumber(body:match("(%d+) apps"))
  assert(claimed, "the page no longer prints a count")

  -- One directory per app. The row list on the page is longer, because it also
  -- names Neovim itself and the surfaces that install from somewhere else.
  local shipped = 0
  for _, entry in ipairs(vim.fn.readdir("extras")) do
    if vim.fn.isdirectory("extras/" .. entry) == 1 then shipped = shipped + 1 end
  end
  assert(claimed == shipped,
    ("the page says %d apps, extras/ ships %d"):format(claimed, shipped))
end)

check("every section of the landing page is a unique deep link", function()
  local body = slurp("docs/index.html")
  local seen = {}
  for id in body:gmatch('id="([%w%-]+)"') do
    assert(not seen[id], "the page uses id=\"" .. id .. "\" twice, so one anchor cannot be reached")
    seen[id] = true
  end
end)

check("the help file defines a tag per section, and quotes the palette it ships", function()
  local body = slurp("doc/sora.txt")

  for name, tag in body:gmatch("%d+%. ([%w ]-) %.+ |(sora%-[%a%-]+)|") do
    -- Plain find: a tag carries a hyphen, which is a quantifier in a pattern.
    assert(body:find("*" .. tag .. "*", 1, true),
      ("the contents list %s but nothing defines |%s|"):format(name, tag))
  end

  -- Hexes inside a >lua block are examples, and two of them are deliberately
  -- not palette values: the on_colors sample overrides a colour to show that it
  -- can be overridden.
  local prose = body:gsub(">lua.-\n<", "")
  local c = require("sora.palette").colors
  local known = {}
  for _, v in pairs(c) do
    if type(v) == "string" and v:match("^#%x%x%x%x%x%x$") then known[v:lower()] = true end
  end
  for hex in prose:gmatch("#%x%x%x%x%x%x") do
    assert(known[hex:lower()], "the help file quotes " .. hex .. ", which the palette does not define")
  end
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
