local M = {}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- matchadd é local à janela, então reaplicamos em cada janela
local function setup_punctuation(c)
  local rules = {
    { "FahrenheitParen",     "[()]",     c.blue },
    { "FahrenheitBrace",     "[{}]",     c.brow },
    { "FahrenheitBracket",   "[\\[\\]]", c.orange },
    { "FahrenheitSemicolon", ";",        c.tomato },
  }

  for _, r in ipairs(rules) do
    hi(r[1], { fg = r[3], bold = true })
  end

  local function apply()
    if vim.w.fahrenheit_matches or vim.bo.buftype ~= "" then
      return
    end
    vim.w.fahrenheit_matches = true
    for _, r in ipairs(rules) do
      vim.fn.matchadd(r[1], r[2], 100)
    end
  end

  vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("FahrenheitPunctuation", { clear = true }),
    callback = apply,
  })

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    vim.api.nvim_win_call(win, apply)
  end
end

function M.setup(c)
  -- 🌑 BASE
  hi("Normal", { fg = c.fg, bg = "NONE" })
  hi("NormalNC", { fg = c.fg, bg = "NONE" })
  hi("NormalFloat", { fg = c.fg, bg = "NONE" })
  hi("SignColumn", { bg = "NONE" })
  hi("Cursor", { fg = c.bg, bg = c.cursor })
  hi("CursorLine", { bg = c.cursorline })
  hi("Visual", { bg = c.selection })
  hi("Search", { fg = c.bg, bg = c.yellow })
  hi("IncSearch", { fg = c.bg, bg = c.orange, bold = true })
  hi("MatchParen", { fg = c.orange, bold = true, underline = true })
  hi("LineNr", { fg = c.comment })
  hi("CursorLineNr", { fg = c.yellow, bold = true })
  hi("NonText", { fg = c.guide })
  hi("Folded", { fg = c.comment, bg = c.cursorline })
  hi("Title", { fg = c.yellow, bold = true })

  -- 💬 COMENTÁRIOS
  hi("Comment", { fg = c.comment, italic = true })

  -- 🔴 KEYWORDS
  for _, g in ipairs({
    "Keyword", "Statement", "Repeat", "Conditional", "Exception",
    "@keyword", "@keyword.conditional", "@keyword.repeat",
    "@keyword.return", "@keyword.function", "@keyword.exception",
  }) do
    hi(g, { fg = c.red, bold = true })
  end

  -- 🟡 FUNÇÕES
  hi("Function", { fg = c.yellow, bold = true })
  hi("@function", { fg = c.yellow, bold = true })
  hi("@function.call", { fg = c.yellow })
  hi("@function.method", { fg = c.yellow })
  hi("@function.method.call", { fg = c.yellow })
  hi("@function.builtin", { fg = c.yellow })

  -- ⚪ VARIÁVEIS E PROPRIEDADES
  hi("Identifier", { fg = c.fg })
  hi("@variable", { fg = c.fg })
  hi("@lsp.type.variable", { fg = c.fg })
  hi("@property", { fg = c.fg })
  hi("@variable.member", { fg = c.fg })

  -- 🟡 PARÂMETROS
  hi("@variable.parameter", { fg = c.yellow, bold = true })
  hi("@lsp.type.parameter", { fg = c.yellow, bold = true })

  -- 🟢 STRINGS
  hi("String", { fg = c.green, bold = true })
  hi("@string", { fg = c.green, bold = true })
  hi("@string.escape", { fg = c.yellow, bold = true })
  hi("@string.regexp", { fg = c.magenta })

  -- 🟡 NÚMEROS, BOOLEANOS E CONSTANTES
  hi("Number", { fg = c.yellow })
  hi("Boolean", { fg = c.yellow })
  hi("@number", { fg = c.yellow })
  hi("@boolean", { fg = c.yellow })
  hi("Constant", { fg = c.yellow })
  hi("@constant", { fg = c.yellow })
  hi("@constant.builtin", { fg = c.orange })

  -- ⚪ OPERADORES E PONTUAÇÃO
  hi("Operator", { fg = c.fg })
  hi("@operator", { fg = c.fg })
  hi("@punctuation.delimiter", { fg = c.fg })

  -- 🟤 TIPOS, MÓDULOS E MISC
  hi("Type", { fg = c.magenta, bold = true })
  hi("@type", { fg = c.magenta })
  hi("@type.builtin", { fg = c.magenta })
  hi("@module", { fg = c.wood })
  hi("Special", { fg = c.orange })
  hi("PreProc", { fg = c.choco })

  -- ⚠️ DIAGNÓSTICOS
  hi("DiagnosticError", { fg = c.firebrick, bold = true })
  hi("DiagnosticWarn", { fg = c.yellow, bold = true })
  hi("DiagnosticInfo", { fg = c.comment })
  hi("DiagnosticHint", { fg = c.comment })
  hi("DiagnosticUnderlineError", { undercurl = true, sp = c.firebrick })
  hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })

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

  -- 📏 INDENTAÇÃO (snacks.indent)
  hi("SnacksIndent", { fg = c.guide })
  hi("SnacksIndentScope", { fg = c.yellow })
  hi("SnacksIndentChunk", { fg = c.yellow })

  -- 🔧 GIT
  hi("GitSignsAdd", { fg = c.green, bold = true })
  hi("GitSignsChange", { fg = c.yellow })
  hi("GitSignsDelete", { fg = c.red, bold = true })

  -- 🎯 PONTUAÇÃO POR TIPO
  setup_punctuation(c)
end

return M
