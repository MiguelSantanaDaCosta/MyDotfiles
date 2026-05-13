local M = {}

function M.setup()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.background = "dark"
  vim.g.colors_name = "fahrenheit"

  local palette = require("fahrenheit.palette")
  local highlights = require("fahrenheit.highlights")

  highlights.setup(palette)
end

return M