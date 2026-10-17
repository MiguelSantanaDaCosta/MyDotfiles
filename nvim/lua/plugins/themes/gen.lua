return {
	"xero/miasma.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- 1. Carrega o tema normalmente
		vim.cmd("colorscheme miasma")

		-- 2. Função para aplicar transparência e negrito
		local function apply_custom_miasma()
			-- Grupos que precisam ficar transparentes (fundo = none)
			local transparent_groups = {
				"Normal",
				"NormalNC",
				"SignColumn",
				"EndOfBuffer",
				"LineNr",
				"CursorLineNr",
				"Folded",
				"VertSplit",
				"WinSeparator",
			}

			for _, group in ipairs(transparent_groups) do
				vim.api.nvim_set_hl(0, group, { bg = "none" })
			end

			-- Grupos que vão ficar em negrito (bold) para melhorar a leitura
			-- Sinta-se livre para remover ou adicionar grupos nesta lista
			local bold_groups = {
				"Comment",
				"Function",
				"Keyword",
				"String",
				"Type",
				"Identifier",
				"Statement",
				"Conditional",
				"Repeat",
				"Operator",
			}

			for _, group in ipairs(bold_groups) do
				-- Pega a cor atual do grupo sem quebrar links
				local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
				if hl then
					hl.bold = true
					vim.api.nvim_set_hl(0, group, hl)
				end
			end
		end

		-- 3. Aplica as configurações na inicialização
		apply_custom_miasma()

		-- 4. Reaplica caso você mude de tema e volte para o miasma
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "miasma",
			callback = apply_custom_miasma,
		})
	end,
}
