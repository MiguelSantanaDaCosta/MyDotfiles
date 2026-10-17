return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"ahmedkhalf/project.nvim", -- necessário para a extensão "projects"
	},

	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fc", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Trocar tema (com preview)" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep Palavra sob o Cursor" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Buscar Atalhos" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnósticos" },
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Símbolos do Arquivo" },
		{ "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Símbolos do Projeto" },
		{ "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buscar no Arquivo Atual" },
		{ "<leader>f.", "<cmd>Telescope resume<cr>", desc = "Retomar Última Busca" },
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_config = { prompt_position = "top" },
				file_ignore_patterns = { "node_modules/", "%.git/", "target/", "build/", "%.class$" },
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob",
					"!**/.git/*",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					},
				},
			},

			pickers = {
				find_files = { hidden = true },
			},

			extensions = {
				["ui-select"] = require("telescope.themes").get_dropdown({}),

				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
		telescope.load_extension("projects")
	end,
}
