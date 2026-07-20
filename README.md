<p align="center">
  <img src="assets/header.svg" alt="Sora" width="800"/>
  <br/><br/>
  A dark Neovim colorscheme. Ethereal cyan, cool silver, deep OLED blacks.
  <br/><br/>
  <a href="#installation">Install</a> &middot;
  <a href="#configuration">Configure</a> &middot;
  <a href="#palette">Palette</a> &middot;
  <a href="#supported-plugins">Plugins</a> &middot;
  <a href="#extras">Extras</a>
  <br/><br/>
  <a href="https://github.com/Aejkatappaja/sora/actions/workflows/ci.yml"><img src="https://github.com/Aejkatappaja/sora/actions/workflows/ci.yml/badge.svg" alt="CI"/></a>
</p>

---

<p align="center">
  <img src="assets/banner.svg" alt="Sora Preview" width="800"/>
</p>

## Philosophy

Sora sits between Tokyo Night's saturation and Lume's muted pastels. The background is near-black with a cool blue undertone, deep enough for OLED. Syntax colors are muted but readable - they don't compete with each other.

The signature ethereal cyan (`#80c8e0`) for functions is lighter and softer than Tokyo Night's blue, cooler than Lume's lavender. A single warm accent - gold (`#d4b878`) for constants and numbers - acts like a star against the cool palette. That one warm point in a field of cool tones is what gives Sora its look.

Eight named accents, each with a clear role. No neon, no Christmas tree.

## Installation

<details>
<summary><b>lazy.nvim</b></summary>

```lua
{
  "Aejkatappaja/sora",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require("sora").setup(opts)
    vim.cmd("colorscheme sora")
  end,
}
```

</details>

<details>
<summary><b>packer.nvim</b></summary>

```lua
use {
  "Aejkatappaja/sora",
  config = function()
    require("sora").setup()
    vim.cmd("colorscheme sora")
  end,
}
```

</details>

<details>
<summary><b>mini.deps</b></summary>

```lua
MiniDeps.add("Aejkatappaja/sora")
require("sora").setup()
vim.cmd("colorscheme sora")
```

</details>

## Configuration

Defaults - pass only what you want to change:

```lua
require("sora").setup({
  transparent = false,      -- transparent background (also strips float/statusline bg)
  italic = true,            -- italics globally
  italic_comments = true,   -- italics for comments (ignored if italic = false)

  on_colors = function(colors) end,        -- override palette before highlights build
  on_highlights = function(hl, colors) end, -- override highlight groups after they build
})
```

### Recipes

<details>
<summary><b>Transparent background</b></summary>

```lua
require("sora").setup({ transparent = true })
```

</details>

<details>
<summary><b>No italics</b></summary>

```lua
require("sora").setup({ italic = false })
-- or keep italics everywhere but comments:
require("sora").setup({ italic_comments = false })
```

</details>

<details>
<summary><b>Pure black OLED background</b></summary>

```lua
require("sora").setup({
  on_colors = function(colors)
    colors.bg = "#000000"
    colors.bg_float = "#000000"
    colors.bg_statusline = "#000000"
  end,
})
```

</details>

<details>
<summary><b>Tweak a syntax color</b></summary>

`on_colors` runs before highlights build, so changing a palette key repaints every group that uses it. Keys live in [`lua/sora/palette.lua`](lua/sora/palette.lua).

```lua
require("sora").setup({
  on_colors = function(colors)
    colors.func = "#a0d8f0"  -- brighter functions
    colors.string = colors.sage
  end,
})
```

</details>

<details>
<summary><b>Override highlight groups</b></summary>

`on_highlights` runs last and wins over everything. Use it for per-group control.

```lua
require("sora").setup({
  on_highlights = function(hl, colors)
    hl.Comment = { fg = colors.fg_comment, italic = true }
    hl.LineNr = { fg = colors.fg_gutter }
    hl.CursorLineNr = { fg = colors.cyan, bold = true }
    hl.FloatBorder = { fg = colors.border, bg = colors.bg_float }
  end,
})
```

</details>

## Palette

| Role       |                     Color                     | Hex       |
| :--------- | :-------------------------------------------: | :-------- |
| Background | ![](https://placehold.co/16x16/0e1018/0e1018) | `#0e1018` |
| Foreground | ![](https://placehold.co/16x16/c8d0e0/c8d0e0) | `#c8d0e0` |
| **Cyan**   | ![](https://placehold.co/16x16/80c8e0/80c8e0) | `#80c8e0` |
| Purple     | ![](https://placehold.co/16x16/b0a0d8/b0a0d8) | `#b0a0d8` |
| Sage       | ![](https://placehold.co/16x16/90c8a0/90c8a0) | `#90c8a0` |
| Peach      | ![](https://placehold.co/16x16/d0a888/d0a888) | `#d0a888` |
| Gold       | ![](https://placehold.co/16x16/d4b878/d4b878) | `#d4b878` |
| Rose       | ![](https://placehold.co/16x16/d0909c/d0909c) | `#d0909c` |
| Teal       | ![](https://placehold.co/16x16/78b8b0/78b8b0) | `#78b8b0` |
| Steel      | ![](https://placehold.co/16x16/8898b8/8898b8) | `#8898b8` |

## Supported Plugins

Sora includes highlight groups for:

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) / [blink.cmp](https://github.com/saghen/blink.cmp)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) / [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) / [oil.nvim](https://github.com/stevearc/oil.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) (built-in theme)
- [mini.statusline](https://github.com/echasnovski/mini.statusline)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) / [snacks.nvim](https://github.com/folke/snacks.nvim)
- [which-key.nvim](https://github.com/folke/which-key.nvim)
- [trouble.nvim](https://github.com/folke/trouble.nvim)
- [lazy.nvim](https://github.com/folke/lazy.nvim) / [mason.nvim](https://github.com/williamboman/mason.nvim)
- [noice.nvim](https://github.com/folke/noice.nvim) / [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [flash.nvim](https://github.com/folke/flash.nvim) / [fzf-lua](https://github.com/ibhagwan/fzf-lua)
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)
- [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)
- [treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)

Full **Treesitter** and **LSP semantic token** support.

### Lualine

```lua
require("lualine").setup({
  options = { theme = "sora" },
})
```

## Extras

Sora everywhere:

| App | File | Install |
|:----|:-----|:--------|
| [Zed](https://zed.dev) | [sora-theme](https://github.com/Aejkatappaja/sora-theme) | **Extensions > search "Sora"**, or [view in directory](https://zed.dev/extensions/sora-theme) |
| [Ghostty](https://ghostty.org) | `extras/ghostty/sora` | `cp` to `~/.config/ghostty/themes/` |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | `extras/kitty/sora.conf` | `include` in `kitty.conf` |
| [Alacritty](https://alacritty.org) | `extras/alacritty/sora.toml` | `import` in `alacritty.toml` |
| [WezTerm](https://wezfurlong.org/wezterm/) | `extras/wezterm/sora.toml` | `cp` to `~/.config/wezterm/colors/` |
| [Foot](https://codeberg.org/dnkl/foot) | `extras/foot/sora.ini` | `include` in `foot.ini` |
| [Vim](https://www.vim.org) | `extras/vim/sora.vim` | `cp` to `~/.vim/colors/` |
| [Helix](https://helix-editor.com) | `extras/helix/sora.toml` | `cp` to `~/.config/helix/themes/`, then set `theme = "sora"` |
| [Lazygit](https://github.com/jesseduffield/lazygit) | `extras/lazygit/sora.yml` | merge into `config.yml` |
| [bat](https://github.com/sharkdp/bat) | `extras/bat/sora.tmTheme` | `cp` to `$(bat --config-dir)/themes/` + `bat cache --build` |
| [Delta](https://github.com/dandavison/delta) | `extras/delta/sora.gitconfig` | `include` in `.gitconfig` (install bat theme first) |
| [Hunk](https://github.com/modem-dev/hunk) | `extras/hunk/sora.toml` | `cp` to `~/.config/hunk/config.toml`, or merge the `[custom_theme]` block |
| [OpenCode](https://opencode.ai) | `extras/opencode/sora.json` | `cp` to `~/.config/opencode/themes/` |
| [fzf](https://github.com/junegunn/fzf) | `extras/fzf/sora.sh` | `source` in shell rc |
| [eza](https://eza.rocks) | `extras/eza/sora.sh` | `source` in shell rc |
| [Starship](https://starship.rs) | `extras/starship/sora.toml` | `cp` to `~/.config/starship.toml`, or merge the `[palettes.sora]` block |
| [Yazi](https://yazi-rs.github.io) | `extras/yazi/sora.toml` | `cp` to `~/.config/yazi/theme.toml` |
| [btop](https://github.com/aristocratos/btop) | `extras/btop/sora.theme` | `cp` to `~/.config/btop/themes/` |
| [tmux](https://github.com/tmux/tmux) | `extras/tmux/sora.tmux.conf` | `source-file` in `tmux.conf` |
| [Herdr](https://herdr.dev) | `extras/herdr/sora.toml` | `cp` to `~/.config/herdr/config.toml`, or merge the `[theme.custom]` block |
| [tokyo-night-tmux](https://github.com/janoamaral/tokyo-night-tmux) | `extras/tmux/tokyo-night-tmux-sora.sh` | see [tmux](#tmux) below |
| [Slack](https://slack.com) | `extras/slack/sora.txt` | paste in Slack sidebar theme |
| [Firefox](https://www.mozilla.org/firefox/) | `extras/firefox/manifest.json` | zip and load via `about:debugging` |
| Firefox Start Page | `extras/firefox-start/index.html` | set as homepage `file://...` (edit `USER` const first) |
| [macOS Terminal](https://support.apple.com/guide/terminal) | `extras/macos-terminal/sora.terminal` | double-click to import |
| [iTerm2](https://iterm2.com) | `extras/macos-terminal/sora.itermcolors` | import in Preferences > Profiles > Colors |
| [Obsidian](https://obsidian.md) | [sora-obsidian](https://github.com/Aejkatappaja/sora-obsidian) | **Settings > Appearance > Themes > Manage > search "Sora"**, or [view in directory](https://community.obsidian.md/themes/sora) |

### tmux

For a basic tmux setup, add to your `tmux.conf`:

```bash
source-file /path/to/sora.nvim/extras/tmux/sora.tmux.conf
```

If you use [tokyo-night-tmux](https://github.com/janoamaral/tokyo-night-tmux), paste the contents of `extras/tmux/tokyo-night-tmux-sora.sh` into the plugin's `src/themes.sh` (before the default `*)` case), then add to your `tmux.conf`:

```bash
set -g @tokyo-night-tmux_theme "sora"
```

## License

MIT
