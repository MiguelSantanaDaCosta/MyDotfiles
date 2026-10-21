return {
	"ficcdaf/ashen.nvim",
	tag = "*",
	lazy = false,
	priority = 1000,
	config = function()
		-- 1. Definição das Variantes
		local variants = {
			normal = {
				transparent = true,
				style = { bold = true },
				colors = {
					foreground = "#D3D3D3",
					red_ember = "#FF5A5A",
				},
			},
			dark = {
				transparent = false, -- Desliga transparência para ficar legível
				style = { bold = true },
				colors = {
					background = "#0A0A0A",
					foreground = "#E0E0E0",
					red_ember = "#FF6B6B",
				},
			},
			light = {
				transparent = false,
				style = { bold = true },
				colors = {
					background = "#FFFFFF",
					foreground = "#000000",
					red_ember = "#D32F2F",
				},
			},
		}

		-- 2. Função que aplica a variante
		local function apply_variant(variant_name)
			local config = variants[variant_name] or variants.normal

			if variant_name == "light" then
				vim.o.background = "light"
			else
				vim.o.background = "dark"
			end

			require("ashen").setup(config)
			vim.cmd("colorscheme ashen")

			-- Ajuste de legibilidade para os menus na versão transparente
			if config.transparent then
				vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

				local menu_bg = "#1A1A1A"
				vim.api.nvim_set_hl(0, "Pmenu", { fg = "#E0E0E0", bg = menu_bg })
				vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#000000", bg = "#FF6B6B", bold = true })
				vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#E0E0E0", bg = menu_bg })
				vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#FF6B6B", bg = menu_bg })
			end
		end

		-- 3. Aplica a variante normal ao iniciar
		apply_variant("normal")

		-- 4. Cria o comando :Ashen que aceita a sintaxe com espaço e hífen
		vim.api.nvim_create_user_command("Ashen", function(opts)
			local variant = opts.args

			-- Remove o hífen (-) caso o usuário digite "-dark" ou "-light"
			variant = variant:gsub("^%-", "")

			-- Se o usuário digitar apenas :Ashen, usa "normal"
			if variant == "" then
				variant = "normal"
			end

			apply_variant(variant)
		end, {
			nargs = "?", -- Aceita 0 ou 1 argumento (com ou sem espaço)
			complete = function()
				-- Autocomplete com o hífen para facilitar sua vida
				return { "-normal", "-dark", "-light" }
			end,
		})
	end,
}
