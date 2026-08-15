local M = {}

function M.get(c)
  return {
    ["@variable"]                    = { fg = c.variable },
    ["@variable.builtin"]            = { fg = c.rose, italic = true },
    ["@variable.parameter"]          = { fg = c.peach },
    ["@variable.parameter.builtin"]  = { fg = c.peach, italic = true },
    ["@variable.member"]             = { fg = c.steel },

    ["@constant"]                    = { fg = c.gold },
    ["@constant.builtin"]            = { fg = c.gold, bold = true },
    ["@constant.macro"]              = { fg = c.teal, bold = true },

    ["@module"]                      = { fg = c.fg_dim },
    ["@module.builtin"]              = { fg = c.fg_dim, italic = true },

    ["@label"]                       = { fg = c.teal },

    ["@string"]                      = { fg = c.sage },
    ["@string.documentation"]        = { fg = c.sage, italic = true },
    ["@string.escape"]               = { fg = c.teal, bold = true },
    ["@string.regexp"]               = { fg = c.teal },
    ["@string.special"]              = { fg = c.teal },
    ["@string.special.symbol"]       = { fg = c.gold },
    ["@string.special.url"]          = { fg = c.cyan, underline = true },
    ["@string.special.path"]         = { fg = c.cyan },

    ["@character"]                   = { fg = c.sage },
    ["@character.special"]           = { fg = c.teal },

    ["@number"]                      = { fg = c.gold },
    ["@number.float"]                = { fg = c.gold },
    ["@boolean"]                     = { fg = c.rose, italic = true },

    ["@type"]                        = { fg = c.peach },
    ["@type.builtin"]                = { fg = c.peach, italic = true },
    ["@type.definition"]             = { fg = c.peach, bold = true },
    ["@type.qualifier"]              = { fg = c.purple, italic = true },

    ["@attribute"]                   = { fg = c.peach },
    ["@attribute.builtin"]           = { fg = c.peach, italic = true },

    ["@function"]                    = { fg = c.cyan },
    ["@function.builtin"]            = { fg = c.cyan, italic = true },
    ["@function.call"]               = { fg = c.cyan },
    ["@function.macro"]              = { fg = c.teal, bold = true },
    ["@function.method"]             = { fg = c.cyan },
    ["@function.method.call"]        = { fg = c.cyan },

    ["@constructor"]                 = { fg = c.peach, bold = true },
    ["@constructor.lua"]             = { fg = c.peach },

    ["@operator"]                    = { fg = c.steel },

    ["@keyword"]                     = { fg = c.purple, italic = true },
    ["@keyword.coroutine"]           = { fg = c.purple, italic = true },
    ["@keyword.function"]            = { fg = c.purple, italic = true },
    ["@keyword.operator"]            = { fg = c.steel },
    ["@keyword.import"]              = { fg = c.purple, italic = true },
    ["@keyword.type"]                = { fg = c.purple },
    ["@keyword.modifier"]            = { fg = c.purple, italic = true },
    ["@keyword.repeat"]              = { fg = c.purple, italic = true },
    ["@keyword.return"]              = { fg = c.purple, italic = true },
    ["@keyword.debug"]               = { fg = c.rose },
    ["@keyword.exception"]           = { fg = c.rose },
    ["@keyword.conditional"]         = { fg = c.purple, italic = true },
    ["@keyword.conditional.ternary"] = { fg = c.steel },
    ["@keyword.directive"]           = { fg = c.purple },
    ["@keyword.directive.define"]    = { fg = c.purple },

    ["@punctuation.bracket"]         = { fg = c.fg_dim },
    ["@punctuation.delimiter"]       = { fg = c.fg_dim },
    ["@punctuation.special"]         = { fg = c.steel },

    ["@comment"]                     = { fg = c.fg_comment, italic = true },
    ["@comment.documentation"]       = { fg = c.fg_comment, italic = true },
    ["@comment.error"]               = { fg = c.error, bold = true },
    ["@comment.warning"]             = { fg = c.warning, bold = true },
    ["@comment.todo"]                = { fg = c.bg, bg = c.gold, bold = true },
    ["@comment.note"]                = { fg = c.bg, bg = c.info, bold = true },

    ["@markup.strong"]               = { fg = c.fg_bright, bold = true },
    ["@markup.italic"]               = { fg = c.fg_bright, italic = true },
    ["@markup.strikethrough"]        = { fg = c.fg_dim, strikethrough = true },
    ["@markup.underline"]            = { underline = true },
    ["@markup.heading"]              = { fg = c.cyan, bold = true },
    ["@markup.heading.1"]            = { fg = c.cyan, bold = true },
    ["@markup.heading.2"]            = { fg = c.purple, bold = true },
    ["@markup.heading.3"]            = { fg = c.peach, bold = true },
    ["@markup.heading.4"]            = { fg = c.sage, bold = true },
    ["@markup.heading.5"]            = { fg = c.gold, bold = true },
    ["@markup.heading.6"]            = { fg = c.rose, bold = true },
    ["@markup.quote"]                = { fg = c.fg_dim, italic = true },
    ["@markup.math"]                 = { fg = c.gold },
    ["@markup.environment"]          = { fg = c.purple },
    ["@markup.link"]                 = { fg = c.cyan, underline = true },
    ["@markup.link.label"]           = { fg = c.cyan },
    ["@markup.link.url"]             = { fg = c.cyan, underline = true },
    ["@markup.raw"]                  = { fg = c.sage },
    ["@markup.raw.block"]            = { fg = c.fg },
    ["@markup.list"]                 = { fg = c.steel },
    ["@markup.list.checked"]         = { fg = c.ok },
    ["@markup.list.unchecked"]       = { fg = c.fg_dim },

    ["@tag"]                         = { fg = c.teal },
    ["@tag.builtin"]                 = { fg = c.teal, italic = true },
    ["@tag.attribute"]               = { fg = c.peach },
    ["@tag.delimiter"]               = { fg = c.fg_dim },

    ["@diff.plus"]                   = { fg = c.git_add },
    ["@diff.minus"]                  = { fg = c.git_delete },
    ["@diff.delta"]                  = { fg = c.git_change },
  }
end

return M
