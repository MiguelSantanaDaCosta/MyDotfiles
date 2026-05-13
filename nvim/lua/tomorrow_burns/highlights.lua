local M = {}

function M.setup(colors, opts)
  local hi = function(group, val)
    vim.api.nvim_set_hl(0, group, val)
  end

  local bg = opts.transparent and "NONE" or colors.bg
  local bg_alt = opts.transparent and "NONE" or colors.bg_alt

  -- Base
  hi("Normal", { fg = colors.fg, bg = bg })
  hi("NormalNC", { fg = colors.fg, bg = bg })
  hi("NormalFloat", { fg = colors.fg, bg = bg_alt })

  hi("Cursor", {
    fg = colors.cursor_txt,
    bg = colors.cursor
  })

  hi("CursorLine", { bg = bg_alt })
  hi("LineNr", { fg = colors.bright_black })
  hi("CursorLineNr", { fg = colors.cursor, bold = true })

  -- Syntax
  hi("Comment", {
    fg = colors.bright_black,
    italic = opts.italic_comments
  })

  hi("String", { fg = colors.green })
  hi("Number", { fg = colors.blue })
  hi("Function", { fg = colors.magenta })
  hi("Keyword", { fg = colors.red, bold = true })
  hi("Type", { fg = colors.cyan })

  -- Treesitter
  hi("@variable", { fg = colors.fg })
  hi("@function", { fg = colors.magenta })
  hi("@string", { fg = colors.green })
  hi("@number", { fg = colors.blue })
  hi("@keyword", { fg = colors.red })
  hi("@type", { fg = colors.cyan })

  -- UI
  hi("Visual", {
    fg = colors.selection_fg,
    bg = colors.selection_bg
  })

  hi("Search", {
    fg = colors.selection_fg,
    bg = colors.selection_bg
  })

  hi("Pmenu", { fg = colors.fg, bg = bg_alt })
  hi("PmenuSel", {
    fg = colors.selection_fg,
    bg = colors.selection_bg
  })

  hi("FloatBorder", { fg = colors.cursor, bg = bg_alt })

  -- Telescope
  hi("TelescopeNormal", { bg = bg_alt })
  hi("TelescopeBorder", { fg = colors.cursor, bg = bg_alt })
  hi("TelescopeSelection", { bg = colors.black })

  -- Neo-tree
  hi("NeoTreeNormal", { bg = bg_alt })
  hi("NeoTreeDirectoryName", { fg = colors.blue })
  hi("NeoTreeRootName", { fg = colors.cursor, bold = true })

  -- Terminal
  hi("TermCursor", {
    fg = colors.cursor_txt,
    bg = colors.cursor
  })

  -- Git
  hi("GitSignsAdd", { fg = colors.green })
  hi("GitSignsChange", { fg = colors.yellow })
  hi("GitSignsDelete", { fg = colors.red })
end

return M