-- lua/plugins/minimap.lua
return {
	"Isrothy/neominimap.nvim",
	cmd = { "MinimapToggle", "MinimapFocus" },
	event = { "BufReadPost", "BufNewFile" },
	init = function()
		vim.g.neominimap = {
			auto_enable = false,
			exclude_filetypes = { "help", "neo-tree", "alpha", "snacks_dashboard", "lazy" },
		}
	end,
	keys = {
		{ "<leader>mm", "<cmd>MinimapToggle<cr>", desc = "Toggle Minimap" },
		{ "<leader>mf", "<cmd>MinimapFocus<cr>", desc = "Focus Minimap" },
	},
}
