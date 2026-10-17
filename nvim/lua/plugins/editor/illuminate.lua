-- lua/plugins/illuminate.lua
return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("illuminate").configure({
			delay = 200,
			large_file_cutoff = 2000,
			filetypes_denylist = { "neo-tree", "alpha", "lazy", "TelescopePrompt" },
		})
	end,
}
