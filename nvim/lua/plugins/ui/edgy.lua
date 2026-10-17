-- Layout de IDE: explorer à esquerda, outline à direita, terminal/trouble/quickfix embaixo
return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.splitkeep = "screen" -- recomendado pelo edgy
	end,
	opts = {
		animate = { enabled = false },
		left = {
			{ title = "Explorer", ft = "neo-tree", size = { width = 35 } },
		},
		right = {
			{ title = "Outline", ft = "aerial", size = { width = 35 } },
		},
		bottom = {
			{
				ft = "toggleterm",
				title = "Terminal",
				size = { height = 0.3 },
				filter = function(_, win)
					return vim.api.nvim_win_get_config(win).relative == ""
				end,
			},
			{ ft = "trouble", title = "Problemas", size = { height = 0.3 } },
			{ ft = "qf", title = "QuickFix", size = { height = 0.25 } },
			{
				ft = "help",
				size = { height = 20 },
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
		},
	},
}
