local M = {}

M.config = {
  transparent = false,
  italic = true,
  italic_comments = true,
  on_colors = function(colors) end,
  on_highlights = function(highlights, colors) end,
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.load()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.g.colors_name = "sora"
  vim.o.termguicolors = true
  vim.o.background = "dark"

  local palette = require("sora.palette")
  local c = vim.deepcopy(palette.colors)

  M.config.on_colors(c)

  local highlights = {}
  local groups = {
    require("sora.groups.editor").get(c),
    require("sora.groups.syntax").get(c),
    require("sora.groups.treesitter").get(c),
    require("sora.groups.lsp").get(c),
    require("sora.groups.integrations").get(c),
  }

  for _, group in ipairs(groups) do
    highlights = vim.tbl_extend("force", highlights, group)
  end

  if M.config.transparent then
    local transparent_groups = {
      "Normal", "NormalNC", "NormalFloat", "SignColumn",
      "FoldColumn", "TabLineFill", "StatusLine", "StatusLineNC",
      "NvimTreeNormal", "NeoTreeNormal", "NeoTreeNormalNC",
      "TreesitterContext",
    }
    for _, name in ipairs(transparent_groups) do
      if highlights[name] then
        highlights[name].bg = "NONE"
      end
    end
    highlights.WinSeparator = { fg = "NONE" }
    highlights.VertSplit = { fg = "NONE" }
    highlights.FloatBorder = { fg = "NONE", bg = "NONE" }
  end

  if not M.config.italic then
    for _, hl in pairs(highlights) do
      hl.italic = false
    end
  elseif not M.config.italic_comments then
    for _, name in ipairs({ "Comment", "@comment", "@comment.documentation" }) do
      if highlights[name] then
        highlights[name].italic = false
      end
    end
  end

  M.config.on_highlights(highlights, c)

  for name, val in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, val)
  end

  vim.g.terminal_color_0  = c.terminal_black
  vim.g.terminal_color_1  = c.terminal_red
  vim.g.terminal_color_2  = c.terminal_green
  vim.g.terminal_color_3  = c.terminal_yellow
  vim.g.terminal_color_4  = c.terminal_blue
  vim.g.terminal_color_5  = c.terminal_magenta
  vim.g.terminal_color_6  = c.terminal_cyan
  vim.g.terminal_color_7  = c.terminal_white
  vim.g.terminal_color_8  = c.terminal_bright_black
  vim.g.terminal_color_9  = c.terminal_bright_red
  vim.g.terminal_color_10 = c.terminal_bright_green
  vim.g.terminal_color_11 = c.terminal_bright_yellow
  vim.g.terminal_color_12 = c.terminal_bright_blue
  vim.g.terminal_color_13 = c.terminal_bright_magenta
  vim.g.terminal_color_14 = c.terminal_bright_cyan
  vim.g.terminal_color_15 = c.terminal_bright_white
end

return M
