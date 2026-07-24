-- Smoke test for the Sora colorscheme.
-- Run: nvim --headless --noplugin -u NONE -c "set rtp+=." -c "luafile test/smoke.lua"
-- Exits non-zero on failure (via :cquit) so CI catches it.

local failures = {}

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

check("lualine theme loads", function()
  local theme = require("lualine.themes.sora")
  assert(theme.normal and theme.normal.a, "lualine theme malformed")
end)

-- Keep this last: it flips the variant to light for the rest of the process.
-- Reset the on_* hooks since earlier checks leave overrides in the shared config.
check("variant = light", function()
  require("sora").setup({
    variant = "light",
    transparent = false,
    on_colors = function() end,
    on_highlights = function() end,
  })
  require("sora").load()
  assert(vim.o.background == "light", "background not set to light")
  assert(vim.api.nvim_get_hl(0, { name = "Normal" }).bg == 0xe4e7ee, "light background not applied")
end)

if #failures > 0 then
  print(("\n%d test(s) failed"):format(#failures))
  vim.cmd("cquit 1")
else
  print("\nall tests passed")
  vim.cmd("quitall")
end
