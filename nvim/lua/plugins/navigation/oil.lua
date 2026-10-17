return {
	-- Editar o sistema de arquivos como um buffer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Abrir pasta atual (Oil)" },
			{ "<leader>-", "<cmd>Oil --float<cr>", desc = "Oil flutuante" },
		},
		opts = {
			default_file_explorer = false, -- o neo-tree continua abrindo diretórios
			columns = { "icon" },
			view_options = { show_hidden = true },
			float = { padding = 4, border = "rounded" },
			keymaps = {
				["<C-h>"] = false, -- mantém a navegação entre painéis
				["<C-l>"] = false,
				["<C-s>"] = false, -- mantém o salvar
				["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Abrir em split vertical" },
				["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Abrir em split horizontal" },
				["q"] = "actions.close",
			},
		},
	},
}
