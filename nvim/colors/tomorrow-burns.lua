vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "tomorrow-burns"

-- 🔥 FORÇA o carregamento correto do lua/
local ok, theme = pcall(require, "tomorrow_burns")

if not ok then
  vim.notify("Erro ao carregar tomorrow_burns", vim.log.levels.ERROR)
  return
end

local colors = require("tomorrow_burns.palette").colors
local opts = theme.get_options()

require("tomorrow_burns.highlights").setup(colors, opts)