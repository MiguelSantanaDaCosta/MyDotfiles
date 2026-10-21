return {
	{
		"zenbones-theme/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- 1. Ativa a transparência e outras opções do Zenbones
			vim.g.zenbones_transparent_background = true
			vim.g.zenbones_italic_comments = true

			-- 2. Carrega o tema (ele adapta-se automaticamente a :set background=dark ou light)
			vim.cmd.colorscheme("zenbones")

			-- 3. Força as janelas flutuantes e menus a terem um fundo opaco
			-- (Pode alterar o '#1c1c1c' consoante prefira um menu mais claro ou mais escuro)
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1c1c1c" })
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#585858", bg = "#1c1c1c" })
			vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1c1c1c" })
		end,
	},
}
