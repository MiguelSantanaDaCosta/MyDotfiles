return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},

	config = function()
		-- jdtls fica de fora do enable: ele é iniciado pelo nvim-jdtls
		local servers = { "lua_ls", "clangd", "basedpyright", "ts_ls", "html", "cssls", "bashls", "jsonls", "yamlls" }

		local to_install = vim.deepcopy(servers)
		table.insert(to_install, "jdtls")

		require("mason-lspconfig").setup({
			ensure_installed = to_install,
			automatic_enable = false, -- ativamos explicitamente logo abaixo
		})

		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		vim.lsp.config("lua_ls", {
			settings = { Lua = { completion = { callSnippet = "Replace" } } },
		})

		vim.lsp.enable(servers)

		vim.diagnostic.config({
			severity_sort = true,
			update_in_insert = false,
			virtual_text = { prefix = "●" },
			float = { border = "rounded", source = true },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = "󰌵 ",
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local map = function(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = "LSP: " .. desc })
				end

				-- Navegação
				map("gd", vim.lsp.buf.definition, "Ir para definição")
				map("gD", vim.lsp.buf.declaration, "Ir para declaração")
				map("gr", "<cmd>Telescope lsp_references<cr>", "Referências")
				map("gI", "<cmd>Telescope lsp_implementations<cr>", "Implementações")
				map("gy", "<cmd>Telescope lsp_type_definitions<cr>", "Definição do tipo")

				-- Diagnósticos
				map("]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, "Próximo diagnóstico")
				map("[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, "Diagnóstico anterior")

				-- Ações
				map("<leader>ca", vim.lsp.buf.code_action, "Code action")
				map("<leader>cr", vim.lsp.buf.rename, "Renomear símbolo")
				map("<leader>cd", vim.diagnostic.open_float, "Diagnóstico da linha")
				map("<leader>ih", function()
					local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
					vim.lsp.inlay_hint.enable(not enabled, { bufnr = ev.buf })
				end, "Alternar inlay hints")
			end,
		})
	end,
}
