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

local offenders = {}
local function check(hex, file)
  if not valid[hex] then
    offenders[#offenders + 1] = file .. "  ->  " .. hex
  end
end

for _, f in ipairs(vim.fn.glob("extras/**/*", false, true)) do
  if vim.fn.isdirectory(f) == 0 then
    for _, line in ipairs(vim.fn.readfile(f)) do
      -- Zed writes the alpha into the hex. The colour is the rgb half, and
      -- #00000000 is its transparent rather than a colour anyone chose, so it
      -- is dropped before the six-digit scan reads its first six zeros.
      line = line:gsub("#(%x%x%x%x%x%x)(%x%x)%f[%W]", function(rgb, alpha)
        if rgb:lower() == "000000" and alpha == "00" then return "" end
        return "#" .. rgb
      end)
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
end
print("ok - every extra color matches the palette")

-- The check above catches a colour that left the palette. This one catches what
-- it cannot see: a generated file edited by hand, or one nobody re-rendered.
-- Every surface under extras/ is generated, so it covers all of them.
local stale, generated = {}, 0
for path, want in pairs(require("sora.extras").files()) do
  generated = generated + 1
  local fd = io.open(path, "r")
  if not fd then
    stale[#stale + 1] = path .. "  ->  missing, run scripts/extras.lua"
  else
    local got = fd:read("*a")
    fd:close()
    if got ~= want then stale[#stale + 1] = path .. "  ->  differs from a fresh render" end
  end
end

if #stale > 0 then
  print("\nGenerated files that no longer match lua/sora/palette.lua:")
  for _, s in ipairs(stale) do print("  " .. s) end
  print("\nRun: nvim --headless --noplugin -u NONE -c \"set rtp+=.\" "
    .. "-c \"luafile scripts/extras.lua\" -c q")
  vim.cmd("cquit 1")
else
  print(("ok - %d generated file(s) match a fresh render"):format(generated))
  vim.cmd("quitall")
end
