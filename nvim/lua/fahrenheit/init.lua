local M = {}

function M.setup()
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end

	vim.o.termguicolors = true
	vim.o.background = "dark"
	vim.g.colors_name = "fahrenheit"

	local colors = require("fahrenheit.palette").colors
	require("fahrenheit.highlights").setup(colors)
end

return M
