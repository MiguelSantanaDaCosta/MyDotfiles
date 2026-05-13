local M = {}

local function hi(group, opts)
  opts.default = false
  vim.api.nvim_set_hl(0, group, opts)
end

function M.setup(c)

  -- 🌑 BASE
  hi("Normal", { fg = c.fg, bg = "NONE" })
  hi("NormalFloat", { fg = c.fg, bg = "NONE" })

  hi("Cursor", { fg = c.bg, bg = c.cursor })
  hi("Visual", { bg = c.selection })

  hi("LineNr", { fg = c.bright_black })
  hi("CursorLineNr", { fg = c.yellow, bold = true })

  -- 💬 COMENTÁRIOS
  hi("Comment", { fg = c.bright_black, italic = true })

  -- 🔴 KEYWORDS
  hi("Keyword", { fg = c.red, bold = true })
  hi("Statement", { fg = c.red, bold = true })
  hi("Repeat", { fg = c.red, bold = true })

  hi("@keyword", { fg = c.red, bold = true })
  hi("@conditional", { fg = c.red, bold = true })
  hi("@repeat", { fg = c.red, bold = true })

  -- 🟡 FUNÇÕES
  hi("Function", { fg = c.yellow, bold = true })
  hi("@function", { fg = c.yellow, bold = true })
  hi("@function.call", { fg = c.yellow })
  hi("@function.method", { fg = c.yellow })

  -- ⚪ VARIÁVEIS
  hi("Identifier", { fg = c.fg })
  hi("@variable", { fg = c.fg })
  hi("@lsp.type.variable", { fg = c.fg })

  -- 🟡 PARÂMETROS
  hi("@parameter", { fg = c.yellow, bold = true })
  hi("@lsp.type.parameter", { fg = c.yellow, bold = true })

  -- ⚪ PROPRIEDADES
  hi("@property", { fg = c.fg })
  hi("@field", { fg = c.fg })

  -- 🟢 STRINGS
  hi("String", { fg = c.green, bold = true })
  hi("@string", { fg = c.green, bold = true })
  hi("@string.escape", { fg = c.yellow, bold = true })
  hi("@string.regex", { fg = c.magenta })

  -- 🟡 NÚMEROS
  hi("Number", { fg = c.yellow })
  hi("Boolean", { fg = c.yellow })
  hi("@number", { fg = c.yellow })
  hi("@boolean", { fg = c.yellow })

  -- ⚪ OPERADORES
  hi("Operator", { fg = c.fg })
  hi("@operator", { fg = c.fg })

  -- 🟤 TIPOS
  hi("Type", { fg = c.magenta, bold = true })
  hi("@type", { fg = c.magenta })

  -- ⚠️ LSP
  hi("DiagnosticError", { fg = c.red, bold = true })
  hi("DiagnosticWarn", { fg = c.yellow, bold = true })
  hi("DiagnosticInfo", { fg = c.bright_black })
  hi("DiagnosticHint", { fg = c.bright_black })

  -- 📊 UI
  hi("StatusLine", { fg = c.fg, bg = "NONE" })
  hi("VertSplit", { fg = c.black })
  hi("WinSeparator", { fg = c.black })

  hi("Pmenu", { fg = c.fg, bg = c.black })
  hi("PmenuSel", { fg = c.bg, bg = c.yellow, bold = true })

  hi("FloatBorder", { fg = c.yellow })

  -- 🔍 Telescope
  hi("TelescopeNormal", { bg = "NONE" })
  hi("TelescopeBorder", { fg = c.yellow })
  hi("TelescopeSelection", { bg = c.black, bold = true })
  hi("TelescopeMatching", { fg = c.yellow, bold = true })

  -- 🌳 Neo-tree
  hi("NeoTreeNormal", { bg = "NONE" })
  hi("NeoTreeDirectoryName", { fg = c.yellow, bold = true })
  hi("NeoTreeFileName", { fg = c.fg })
  hi("NeoTreeRootName", { fg = c.red, bold = true })

  -- 📏 INDENTAÇÃO
  hi("IblIndent", { fg = c.bright_black, bold = true })
  hi("IblScope", { fg = c.yellow, bold = true })

  -- 🔧 GIT
  hi("GitSignsAdd", { fg = c.green, bold = true })
  hi("GitSignsChange", { fg = c.yellow })
  hi("GitSignsDelete", { fg = c.red, bold = true })

  -- ⚡ CMP
  hi("CmpItemKind", { fg = c.yellow })
  hi("CmpItemKindVariable", { fg = c.fg })
  hi("CmpItemKindProperty", { fg = c.fg })
  hi("CmpItemKindField", { fg = c.fg })

   
  -- ==============================
-- 🎯 PONTUAÇÃO AVANÇADA
-- ==============================

vim.fn.clearmatches()

-- () → blue
vim.fn.matchadd("FahrenheitParen", "[()]", 100)
hi("FahrenheitParen", { fg = c.blue, bold = true })

-- {} → brow
vim.fn.matchadd("FahrenheitBrace", "[{}]", 100)
hi("FahrenheitBrace", { fg = c.brow, bold = true })

-- [] → orange
vim.fn.matchadd("FahrenheitBracket", "[\\[\\]]", 100)
hi("FahrenheitBracket", { fg = c.orange, bold = true })

-- ; → tomato
vim.fn.matchadd("FahrenheitSemicolon", ";", 100)
hi("FahrenheitSemicolon", { fg = c.tomato, bold = true })




end

return M