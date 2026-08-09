-- Write the generated files under extras/ from lua/sora/palette.lua.
--
-- Run: nvim --headless --noplugin -u NONE -c "set rtp+=." -c "luafile scripts/extras.lua" -c q
--
-- The builders live under lua/sora/extras/ so that test/extras.lua can check the
-- committed files against a fresh render without writing anything.

for path, body in pairs(require("sora.extras").files()) do
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
  local fd = assert(io.open(path, "w"))
  fd:write(body)
  fd:close()
  print("wrote " .. path)
end
