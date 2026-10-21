-- Black Metal: 16 temas inspirados em bandas (bathory, burzum, darkthrone...), com fundo transparente.
-- :colorscheme bathory | bathory-alt | <banda> | <banda>-alt   (variantes light desligadas, trve = true)
local bands = {
	"bathory",
	"burzum",
	"dark-funeral",
	"darkthrone",
	"emperor",
	"gorgoroth",
	"immortal",
	"impaled-nazarene",
	"khold",
	"marduk",
	"mayhem",
	"nile",
	"taake",
	"thyrfing",
	"venom",
	"windir",
}

return {
	"metalelf0/black-metal-theme-neovim",
	lazy = true, -- o lazy.nvim carrega sozinho no primeiro :colorscheme <banda>
	priority = 1000,
	config = function()
		local blend = function(a, b, t)
			return require("black-metal.utils").blend(a, b, t)
		end
		-- menus: fundo levemente mais claro que o bg do tema, sempre legível
		local menu_bg = function(p)
			return blend(p.fg, p.bg, 0.08)
		end
		local sel_bg = function(p)
			return blend(p.fg, p.bg, 0.20)
		end

		require("black-metal").setup({
			theme = "bathory", -- usado por require("black-metal").load()
			variant = "dark",
			alt_bg = false,
			trve = true, -- sem variantes claras (terminal transparente escuro)

			transparent = true, -- não pinta o fundo: o wallpaper aparece
			plain_float = true, -- janelas flutuantes com borda também sem fundo
			show_eob = false, -- sem o "~" no fim do buffer
			dark_gutter = false,
			cursorline_gutter = false, -- sem faixa de fundo na coluna de sinais
			term_colors = true,

			diagnostics = {
				darker = true,
				undercurl = true,
				background = false, -- sem faixa de fundo no virtual text
			},
			code_style = {
				comments = "italic",
				keywords = "bold",
				functions = "bold",
				headings = "bold",
			},

			-- Menus de autocomplete sólidos (o resto fica transparente)
			highlights = {
				Pmenu = { fg = "$fg", bg = menu_bg },
				PmenuSbar = { bg = menu_bg },
				PmenuSel = { bg = sel_bg, fmt = "bold" },
				BlinkCmpMenu = { fg = "$fg", bg = menu_bg },
				BlinkCmpDoc = { fg = "$fg", bg = menu_bg },
				BlinkCmpMenuSelection = { bg = sel_bg, fmt = "bold" },
			},
		})

		-- limpa os fundos de neo-tree, telescope, bufferline, which-key etc. em todos os temas das bandas
		local patterns = {}
		for _, b in ipairs(bands) do
			patterns[#patterns + 1] = b .. "*"
		end
		require("theme_transparency").attach("black_metal", patterns, {})
	end,
}
