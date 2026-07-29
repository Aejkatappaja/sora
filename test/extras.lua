-- Extras color-drift guard.
-- Every color literal in extras/ must be a current palette value (or a known
-- derived shade). The Neovim smoke test only exercises the runtime highlights,
-- so nothing otherwise catches an extra config left stale after a palette edit.
-- Run: nvim --headless --noplugin -u NONE -c "set rtp+=." -c "luafile test/extras.lua"

local palette = require("sora.palette").colors

-- valid = every #rrggbb that appears as a palette value
local valid = {}
for _, v in pairs(palette) do
  if type(v) == "string" then
    local h = v:match("^#(%x%x%x%x%x%x)$")
    if h then valid["#" .. h:lower()] = true end
  end
end

-- Derived shades intentionally used by a few extras (diff backgrounds that are
-- blended, not raw palette colors). Update this list only alongside those files.
for _, h in ipairs({
  "#0d1f22", "#142c1c", "#163524", "#171426", "#283448", "#2a1420", "#35161c",
}) do
  valid[h] = true
end

local offenders = {}
local function check(hex, file)
  if not valid[hex] then
    offenders[#offenders + 1] = file .. "  ->  " .. hex
  end
end

for _, f in ipairs(vim.fn.glob("extras/**/*", false, true)) do
  if vim.fn.isdirectory(f) == 0 then
    for _, line in ipairs(vim.fn.readfile(f)) do
      for form in line:gmatch("#%x%x%x%x%x%x") do   -- #rrggbb
        check(form:lower(), f)
      end
      for form in line:gmatch("0x(%x%x%x%x%x%x)") do -- 0xrrggbb (alacritty etc)
        check("#" .. form:lower(), f)
      end
    end
  end
end

if #offenders > 0 then
  print("Extra configs use colors that are not in lua/sora/palette.lua:")
  for _, o in ipairs(offenders) do print("  " .. o) end
  print(("\n%d stale color(s) - regenerate the extra or update the palette"):format(#offenders))
  vim.cmd("cquit 1")
else
  print("ok - every extra color matches the palette")
  vim.cmd("quitall")
end
