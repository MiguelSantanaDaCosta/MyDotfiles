return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = false,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			inverse = true,
			contrast = "hard", -- "", "soft" ou "hard"
			dim_inactive = false,
			transparent_mode = true, -- mesmo fundo transparente do Fahrenheit
		})
	end,
}
