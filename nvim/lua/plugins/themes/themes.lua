-- Temas para testar (todos lazy: carregam só quando você roda :colorscheme <nome>)
-- Todos com fundo transparente e negrito onde o tema permite.
return {
	-- :colorscheme rose-pine-moon | rose-pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		opts = {
			variant = "moon",
			styles = { bold = true, italic = true, transparency = true },
		},
	},

	-- :colorscheme vague
	{
		"vague2k/vague.nvim",
		lazy = true,
		opts = { transparent = true, bold = true, italic = true },
	},

	-- :colorscheme duskfox | carbonfox | nordfox | terafox | nightfox
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		opts = {
			options = {
				transparent = true,
				styles = { comments = "italic,bold", keywords = "bold", functions = "bold", types = "bold" },
			},
		},
	},

	-- :colorscheme tokyonight-moon | tokyonight-night | tokyonight-storm
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "moon",
			transparent = true,
			styles = {
				comments = { italic = true, bold = true },
				keywords = { bold = true },
				functions = { bold = true },
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},

	-- :colorscheme gruvbox-material
	{
		"sainnhe/gruvbox-material",
		lazy = true,
		init = function()
			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_enable_italic = 1
		end,
	},

	-- :colorscheme everforest
	{
		"sainnhe/everforest",
		lazy = true,
		init = function()
			vim.g.everforest_background = "medium"
			vim.g.everforest_transparent_background = 1
			vim.g.everforest_enable_italic = 1
			vim.g.everforest_better_performance = 1
		end,
	},
}
