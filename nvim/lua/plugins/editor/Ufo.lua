-- Folding estilo VSCode com treesitter/indent
return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	event = "BufReadPost",
	init = function()
		vim.o.foldcolumn = "0"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,
	config = function()
		require("ufo").setup({
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		})
		vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Abrir todos os folds" })
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Fechar todos os folds" })
	end,
}
