-- Paleta estática do Fahrenheit (edite à vontade).
local M = {}

M.colors = {
	-- base
	bg = "#14100e",
	fg = "#e8dcc8",

	cursor = "#e8dcc8",
	selection = "#4a2c20",
	selection_fg = "#f5e6d0",

	comment = "#8a7a68",
	guide = "#3a2e28",
	cursorline = "#1e1815",

	-- ANSI 0-7
	black = "#241c18",
	red = "#e0603c",
	green = "#a9b665",
	yellow = "#e8b04e",
	blue = "#7fa6b8",
	magenta = "#c97a8a",
	cyan = "#2f4a4a",
	white = "#e8dcc8",

	-- extras (usados pelo highlights.lua)
	tomato = "#ff6347",
	sienna = "#6b2f1c",
	rosy = "#7a5a52",
	wood = "#a07850",
	firebrick = "#e5533d",
	brow = "#b5764a",
	choco = "#d2691e",
	indi = "#6b3a2e",
	orange = "#e08a3c",

	-- ANSI 8-15
	bright_black = "#2e2420",
	bright_red = "#f07a5a",
	bright_green = "#2f3d22",
	bright_yellow = "#f2c36b",
	bright_blue = "#9bbfd0",
	bright_magenta = "#dd95a3",
	bright_cyan = "#3d6060",
	bright_white = "#f5ebdc",
}

return M
