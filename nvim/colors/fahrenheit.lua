local palette = require("fahrenheit.palette").colors
local highlights = require("fahrenheit.highlights")

-- limpa tudo
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "fahrenheit"

-- 👇 AQUI É O QUE FALTA
highlights.setup(palette)