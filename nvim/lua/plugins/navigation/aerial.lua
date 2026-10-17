-- lua/plugins/aerial.lua
return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
		layout = { min_width = 28 },
		show_guides = true,
		filter_kind = false,
		guides = { mid_item = "├╴", last_item = "└╴" },
	},
	keys = {
		{ "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Symbols Outline" },
		{ "<leader>on", "<cmd>AerialNext<CR>", desc = "Next Symbol" },
		{ "<leader>op", "<cmd>AerialPrev<CR>", desc = "Prev Symbol" },
	},
}
