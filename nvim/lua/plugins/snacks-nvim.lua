-- Terminal flutuante (pop-up) centralizado
local function float_term()
	Snacks.terminal(nil, {
		win = {
			position = "float",
			border = "rounded",
			width = 0.85,
			height = 0.8,
		},
	})
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dashboard = { enabled = false }, -- o alpha cuida disso

		notifier = { enabled = true, timeout = 3000, style = "fancy" },

		indent = {
			enabled = true,
			char = "│",
			scope = { enabled = true, char = "▎", underline = false },
			chunk = { enabled = true },
		},

		picker = { enabled = false }, -- você usa o Telescope
		input = { enabled = true },
		select = { enabled = false }, -- telescope-ui-select já cuida

		image = { enabled = true },
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = false },

		terminal = {
			enabled = true,
			win = { style = "terminal", border = "rounded" },
		},

		scroll = { enabled = true },
		zen = { enabled = false }, -- você usa o zen-mode.nvim
		util = { enabled = true },
	},

	keys = {
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Histórico de Notificações",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Limpar Notificações",
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Abrir LazyGit",
		},
		{ "<c-/>", float_term, desc = "Terminal Flutuante", mode = { "n", "t" } },
		{ "<c-_>", float_term, desc = "Terminal Flutuante", mode = { "n", "t" } },
		{ "<A-t>", float_term, desc = "Terminal Flutuante", mode = { "n", "t" } },
	},
}
