-- lua/plugins/inc-rename.lua
return {
	"smjonas/inc-rename.nvim",
	cmd = "IncRename",
	keys = {
		{
			"<leader>cR",
			function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			expr = true,
			desc = "Renomear incremental",
		},
	},
	opts = {},
}
