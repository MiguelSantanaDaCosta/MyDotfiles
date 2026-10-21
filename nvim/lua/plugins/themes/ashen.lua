return {
	{
		"https://codeberg.org/ficd/ashen.nvim.git",
		version = false,
		config = function()
			-- Função para reconfigurar e aplicar o tema dinamicamente
			local function load_ashen(mode)
				local is_light = (mode == "light")

				-- Substitui as variáveis base do Ashen dependendo do modo
				local custom_colors = is_light
						and {
							background = "#FFFFFF",
							g_3 = "#000000",
							g_8 = "#E0E0E0",
							g_9 = "#F5F5F5",
							red_ember = "#D32F2F",
						}
					or { background = "#121212", red_ember = "#FF6B6B" }

				require("ashen").setup({
					transparent = true,
					style_presets = {
						bold_functions = true,
						italic_comments = true,
					},
					colors = custom_colors,
					hl = {
						merge_override = {
							-- Força negrito nos textos normais e menus
							Normal = { nil, nil, { bold = true } },
							NormalFloat = { nil, is_light and "#FFFFFF" or "#0A0A0A", { bold = true } },
							FloatBorder = { is_light and "#D32F2F" or "#FF6B6B", is_light and "#FFFFFF" or "#0A0A0A" },
							Pmenu = { nil, is_light and "#F5F5F5" or "#0A0A0A", { bold = true } },
							PmenuSel = {
								is_light and "#FFFFFF" or "#000000",
								is_light and "#D32F2F" or "#FF6B6B",
								{ bold = true },
							},
						},
					},
				})

				-- Recarrega o tema para aplicar as novas configurações
				vim.cmd("colorscheme ashen")
			end

			-- Carrega o modo Dark por padrão ao iniciar o Neovim
			load_ashen("dark")

			-- Cria os comandos personalizados para alternar os modos
			vim.api.nvim_create_user_command("AshenLight", function()
				load_ashen("light")
			end, {})
			vim.api.nvim_create_user_command("AshenDark", function()
				load_ashen("dark")
			end, {})
		end,
	},
}
