-- lua/plugins/which-key.lua
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = 200,
		win = { border = "rounded" },
		icons = { mappings = true },
		spec = {
			-- Grupos com <leader>
			{ "<leader>f", group = "Find", icon = "" },
			{ "<leader>g", group = "Git", icon = "" },
			{ "<leader>l", group = "LSP", icon = "" },
			{ "<leader>d", group = "Debug", icon = "" },
			{ "<leader>t", group = "Test", icon = "" },
			{ "<leader>b", group = "Buffer", icon = "" },
			{ "<leader>j", group = "Java", icon = "" },
			{ "<leader>r", group = "Run/Refactor", icon = "" },
			{ "<leader>w", group = "Window/Splits", icon = "" },
			{ "<leader>c", group = "Code", icon = "" },
			{ "<leader>x", group = "Diagnostics", icon = "" },
			{ "<leader>q", group = "Sessão", icon = "" },
			{ "<leader>o", group = "Symbols", icon = "" },
			{ "<leader>m", group = "Minimap", icon = "" },
			{ "<leader>u", group = "UI/Undo", icon = "" },

			-- Atalhos soltos (aparecem no guia com descrição)
			{ "<C-h>", desc = "Painel à esquerda", mode = "n" },
			{ "<C-j>", desc = "Painel abaixo", mode = "n" },
			{ "<C-k>", desc = "Painel acima", mode = "n" },
			{ "<C-l>", desc = "Painel à direita", mode = "n" },
			{ "<C-/>", desc = "Terminal flutuante", mode = { "n", "t" } },
			{ "<A-t>", desc = "Terminal flutuante", mode = { "n", "t" } },
			{ "<C-e>", desc = "Menu do Harpoon", mode = "n" },
			{ "<S-h>", desc = "Buffer anterior", mode = "n" },
			{ "<S-l>", desc = "Próximo buffer", mode = "n" },
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
			"<leader>w<space>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Modo janela (hydra)",
		},
	},
}
