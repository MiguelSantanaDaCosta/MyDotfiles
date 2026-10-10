-- lua/plugins/fidget.lua
return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		notification = { window = { winblend = 0 } },
	},
}
