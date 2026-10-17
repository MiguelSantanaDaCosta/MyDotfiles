return {
	"rebelot/kanagawa.nvim",
	lazy = true, -- o lazy.nvim carrega sozinho quando você roda :colorscheme kanagawa-dragon
	priority = 1000,
	opts = {
		compile = false,
		transparent = true, -- deixa o wallpaper aparecer
		dimInactive = false,
		terminalColors = true,
		theme = "dragon",
		background = { dark = "dragon", light = "lotus" },

		-- Negrito para melhorar a leitura sobre o wallpaper
		commentStyle = { italic = true, bold = true },
		keywordStyle = { italic = false, bold = true },
		statementStyle = { bold = true },
		typeStyle = { bold = true },
		functionStyle = { bold = true },

		colors = {
			theme = {
				all = { ui = { bg_gutter = "none" } }, -- números de linha/sinais sem fundo
			},
		},

		overrides = function(colors)
			local theme = colors.theme
			return {
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },
				-- menu de autocomplete continua opaco (legibilidade)
				Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
				PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar = { bg = theme.ui.bg_m1 },
				PmenuThumb = { bg = theme.ui.bg_p2 },
				TelescopeNormal = { bg = "none" },
				TelescopeBorder = { bg = "none" },
				NeoTreeNormal = { bg = "none" },
				NeoTreeNormalNC = { bg = "none" },
				StatusLine = { bg = "none" },
				StatusLineNC = { bg = "none" },
			}
		end,
	},
}
