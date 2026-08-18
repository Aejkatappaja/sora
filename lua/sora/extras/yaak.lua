local M = {}

-- The Yaak plugin. Yaak installs a package instead of reading this repository,
-- so extras/yaak is what `yaakcli build` publishes.

local palette = require("sora.palette")

local THEME = [==[
import type { PluginDefinition } from '@yaakapp/api';

// Generated from lua/sora/palette.lua by scripts/extras.lua.

export const plugin: PluginDefinition = {
  themes: [
    {
      id: 'sora',
      label: 'Sora',
      dark: true,
      base: {
        surface: '@bg@',
        surfaceHighlight: '@bg_cursorline@',
        surfaceActive: '@bg_selected@',
        selection: '@bg_selection@',
        text: '@fg@',
        textSubtle: '@fg_dim@',
        textSubtlest: '@fg_comment@',
        border: '@border@',
        borderSubtle: '@separator@',
        borderFocus: '@accent@',
        primary: '@accent@',
        secondary: '@purple@',
        info: '@info@',
        success: '@ok@',
        notice: '@peach@',
        warning: '@warning@',
        danger: '@error@',
      },
      components: {
        appHeader: { surface: '@bg_statusline@', border: '@separator@' },
        sidebar: { surface: '@bg_float@', border: '@separator@' },
        responsePane: { surface: '@bg@', border: '@border@' },
        editor: { surface: '@bg@' },
        dialog: { surface: '@bg_elevated@', border: '@border@' },
        menu: { surface: '@bg_elevated@', border: '@border@' },
        toast: { surface: '@bg_elevated@', border: '@border@' },
        input: { surface: '@bg_elevated@', border: '@border@' },
        urlBar: { surface: '@bg_elevated@', border: '@border@' },
        button: {
          primary: '@accent@',
          secondary: '@purple@',
          info: '@info@',
          success: '@ok@',
          notice: '@peach@',
          warning: '@warning@',
          danger: '@error@',
        },
      },
    },
  ],
};
]==]

--- Roles are the Neovim ones: cyan is the accent, purple is a keyword, and peach
--- takes `notice` so a notice and a warning are not two shades of the same gold.
--- `shadow` and `backdrop` are left out because both want alpha.
--- @return string
function M.theme()
  local c = palette.colors

  local vars = {
    accent = c.accent,
    bg = c.bg,
    bg_cursorline = c.bg_cursorline,
    bg_elevated = c.bg_elevated,
    bg_float = c.bg_float,
    bg_selected = c.bg_selected,
    bg_selection = c.bg_selection,
    bg_statusline = c.bg_statusline,
    border = c.border,
    error = c.error,
    fg = c.fg,
    fg_comment = c.fg_comment,
    fg_dim = c.fg_dim,
    info = c.info,
    ok = c.ok,
    peach = c.peach,
    purple = c.purple,
    separator = c.separator,
    warning = c.warning,
  }

  return (THEME:gsub("@([%w_]+)@", vars))
end

--- The package manifest. The version is a literal for the same reason the Zed one
--- is: read from the release manifest, a release would re-render this file at a
--- new number and fail the drift check.
--- @return string
function M.package_json()
  return [[
{
  "name": "@aejkatappaja/sora-theme",
  "displayName": "Sora for Yaak",
  "description": "A dark theme inspired by the sky above. Ethereal cyan, cool silver, deep OLED blacks.",
  "version": "0.1.0",
  "private": false,
  "license": "MIT",
  "author": "aejkatappaja",
  "repository": {
    "type": "git",
    "url": "https://github.com/Aejkatappaja/sora.git"
  },
  "keywords": ["yaak", "yaak-plugin", "theme", "dark", "sora"],
  "scripts": {
    "build": "yaakcli build"
  },
  "dependencies": {
    "@yaakapp/api": "^0.8.3"
  },
  "devDependencies": {
    "@yaakapp/cli": "^2026.6.1",
    "typescript": "^5.5.2"
  }
}
]]
end

--- @return string
function M.tsconfig()
  return [[
{
  "compilerOptions": {
    "target": "es2021",
    "module": "ESNext",
    "moduleResolution": "Node",
    "lib": ["ESNext"],
    "strict": true,
    "noEmit": true,
    "skipLibCheck": true,
    "isolatedModules": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src"]
}
]]
end

return M
