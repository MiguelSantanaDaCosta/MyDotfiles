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
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count)
				return "(" .. count .. ")"
			end,
			hover = { enabled = true, delay = 150, reveal = { "close" } },
			-- Fecha o buffer sem fechar o split
			close_command = function(n)
				Snacks.bufdelete(n)
			end,
			right_mouse_command = function(n)
				Snacks.bufdelete(n)
			end,
			-- A barra não fica por cima do neo-tree
			offsets = {
				{ filetype = "neo-tree", text = "Explorador", text_align = "center", separator = true },
			},
		},
	},
	keys = {
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Próximo buffer" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer anterior" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Próximo buffer" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer anterior" },
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Fechar buffer (mantém o split)" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Fechar os outros buffers" },
		{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Escolher buffer por letra" },
		{ "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Fechar buffer por letra" },
		{ "<leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "Fixar/Desafixar buffer" },
	},
}
