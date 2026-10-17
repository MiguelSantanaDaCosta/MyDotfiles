-- lua/plugins/goto-preview.lua
return {
	"rmagatti/goto-preview",
	event = "LspAttach",
	config = function()
		require("goto-preview").setup({
			width = 120,
			height = 20,
			border = { "rounded" },
			default_mappings = true,
		})
	end,
}
