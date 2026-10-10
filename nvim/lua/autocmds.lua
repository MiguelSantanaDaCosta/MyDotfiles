local augroup = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Destaca o texto copiado (yank)
autocmd("TextYankPost", {
	group = augroup,
	desc = "Highlight ao copiar",
	callback = function()
		(vim.hl or vim.highlight).on_yank({ timeout = 150 })
	end,
})

-- Volta para a última posição do cursor ao reabrir um arquivo
autocmd("BufReadPost", {
	group = augroup,
	desc = "Restaurar posição do cursor",
	callback = function(ev)
		local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
		local lines = vim.api.nvim_buf_line_count(ev.buf)
		if mark[1] > 0 and mark[1] <= lines and vim.bo[ev.buf].filetype ~= "gitcommit" then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Recarrega o arquivo se ele mudou fora do Neovim
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup,
	desc = "Checar arquivos alterados externamente",
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Reequilibra os splits quando a janela do terminal muda de tamanho
autocmd("VimResized", {
	group = augroup,
	desc = "Igualar splits ao redimensionar",
	callback = function()
		local tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. tab)
	end,
})

-- Fecha janelas auxiliares com "q"
autocmd("FileType", {
	group = augroup,
	pattern = { "help", "qf", "man", "checkhealth", "lspinfo", "notify", "startuptime", "query" },
	desc = "Fechar janelas auxiliares com q",
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true, desc = "Fechar janela" })
	end,
})

-- Wrap e spell em textos
autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "gitcommit", "text" },
	desc = "Wrap e spellcheck em textos",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- Cria pastas que faltam ao salvar (ex: :w src/novo/arquivo.lua)
autocmd("BufWritePre", {
	group = augroup,
	desc = "Criar diretórios ausentes ao salvar",
	callback = function(ev)
		if ev.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local dir = vim.fn.fnamemodify(vim.uv.fs_realpath(ev.match) or ev.match, ":p:h")
		vim.fn.mkdir(dir, "p")
	end,
})
