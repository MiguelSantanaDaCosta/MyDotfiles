-- lua/plugins/rest.lua
return {
	"rest-nvim/rest.nvim",
	ft = "http",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>Rr", "<cmd>Rest run<cr>", desc = "Rodar requisição HTTP" },
	},
	opts = {},
}
