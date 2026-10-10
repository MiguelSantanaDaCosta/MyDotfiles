-- lua/plugins/bufferline.lua
return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			mode = "buffers",
			separator_style = "slant",
			always_show_bufferline = false,
			show_buffer_close_icons = true,
			show_close_icon = false,
		},
	},
	keys = {
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Próximo buffer" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer anterior" },
		{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Fechar buffer" },
	},
}
