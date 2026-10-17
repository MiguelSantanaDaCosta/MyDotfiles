-- lua/plugins/which-key.lua
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = 200,
		expand = 1, -- grupos pequenos já aparecem expandidos na lista
		win = {
			border = "rounded",
			padding = { 1, 2 },
			title = true,
			title_pos = "center",
		},
		layout = { spacing = 4 },
		icons = { mappings = true, separator = "➜" },
		show_help = true,
		spec = {
			-- Grupos com <leader> (o which-key escolhe o ícone pelo nome)
			{ "<leader>f", group = "Buscar (Find)" },
			{ "<leader>g", group = "Git" },
			{ "<leader>l", group = "LSP / LazyGit" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>t", group = "Testes" },
			{ "<leader>b", group = "Buffers" },
			{ "<leader>j", group = "Java" },
			{ "<leader>r", group = "Rodar / Refatorar" },
			{ "<leader>w", group = "Janelas / Splits" },
			{ "<leader>c", group = "Código" },
			{ "<leader>x", group = "Diagnósticos" },
			{ "<leader>q", group = "Sessão / Sair" },
			{ "<leader>o", group = "Símbolos (Outline)" },
			{ "<leader>m", group = "Minimap" },
			{ "<leader>u", group = "UI / Undo" },
			{ "<leader>s", group = "Buscar TODOs" },
			{ "<leader>i", group = "Inlay hints" },
			{ "<leader>n", group = "Notificações / Docs" },
			{ "<leader>R", group = "REST" },

			-- Atalhos soltos (aparecem no guia com descrição)
			{ "<C-h>", desc = "Painel à esquerda", mode = "n" },
			{ "<C-j>", desc = "Painel abaixo", mode = "n" },
			{ "<C-k>", desc = "Painel acima", mode = "n" },
			{ "<C-l>", desc = "Painel à direita", mode = "n" },
			{ "<C-s>", desc = "Salvar arquivo", mode = { "n", "i", "x" } },
			{ "<C-/>", desc = "Terminal flutuante", mode = { "n", "t" } },
			{ "<A-t>", desc = "Terminal flutuante", mode = { "n", "t" } },
			{ "<C-e>", desc = "Menu do Harpoon", mode = "n" },
			{ "<A-1>", desc = "Harpoon: arquivo 1", mode = "n" },
			{ "<A-2>", desc = "Harpoon: arquivo 2", mode = "n" },
			{ "<A-3>", desc = "Harpoon: arquivo 3", mode = "n" },
			{ "<A-4>", desc = "Harpoon: arquivo 4", mode = "n" },
			{ "<S-h>", desc = "Buffer anterior", mode = "n" },
			{ "<S-l>", desc = "Próximo buffer", mode = "n" },
			{ "-", desc = "Abrir pasta atual (Oil)", mode = "n" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Atalhos do buffer atual",
		},
		{
			"<leader><leader>",
			"<cmd>Telescope keymaps<cr>",
			desc = "Pesquisar todos os atalhos",
		},
		{
			"<leader>w<space>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Modo janela (hydra)",
		},
	},
}
