-- ============================================================
-- Leaders (defina no init.lua ANTES de plugins carregarem)
-- ============================================================
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap.set

-- ============================================================
-- Opções que afetam splits
-- ============================================================
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ============================================================
-- Geral
-- ============================================================
keymap("n", "<Esc>", ":noh<CR>", { desc = "Limpar Destaques", silent = true })
keymap("n", "<leader>rn", ":set relativenumber!<CR>", { desc = "Alternar Relativenumber", silent = true })

-- ============================================================
-- Redimensionar janela
-- ============================================================
keymap("n", "<A-=>", "<C-w>+", { desc = "Aumentar Altura da Janela" })
keymap("n", "<A-->", "<C-w>-", { desc = "Diminuir Altura da Janela" })
keymap("n", "<A-,>", "<C-w>>", { desc = "Aumentar Largura da Janela" })
keymap("n", "<A-.>", "<C-w><", { desc = "Diminuir Largura da Janela" })

-- ============================================================
-- Navegação entre janelas
-- ============================================================
keymap("n", "<C-K>", "<C-w>k", { desc = "Mover para Janela Acima" })
keymap("n", "<C-J>", "<C-w>j", { desc = "Mover para Janela Abaixo" })
keymap("n", "<C-H>", "<C-w>h", { desc = "Mover para Janela à Esquerda" })
keymap("n", "<C-L>", "<C-w>l", { desc = "Mover para Janela à Direita" })

-- ============================================================
-- Mover linhas
-- ============================================================
keymap("n", "<A-Up>", ":m .-2<CR>", { desc = "Mover Linha para Cima", silent = true })
keymap("n", "<A-Down>", ":m .+1<CR>", { desc = "Mover Linha para Baixo", silent = true })
keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Mover Linhas para Cima", silent = true })
keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Mover Linhas para Baixo", silent = true })

-- ============================================================
-- Indentação
-- ============================================================
keymap("n", "<Tab>", ">>", { desc = "Indentar Linha" })
keymap("n", "<S-Tab>", "<<", { desc = "Desindentar Linha" })
keymap("v", "<Tab>", ">gv", { desc = "Indentar Seleção" })
keymap("v", "<S-Tab>", "<gv", { desc = "Desindentar Seleção" })

-- ============================================================
-- Maximizar / restaurar janela atual
-- ============================================================
vim.api.nvim_create_user_command("MaximizeToggle", function()
	if vim.w.maximized then
		vim.cmd(vim.w.maximized_restore)
		vim.w.maximized = false
	else
		vim.w.maximized_restore = vim.fn.winrestcmd()
		vim.cmd("wincmd |") -- maximizar largura
		vim.cmd("wincmd _") -- maximizar altura
		vim.w.maximized = true
	end
end, { desc = "Maximizar/Restaurar janela" })

-- ============================================================
-- Splits
-- ============================================================
keymap("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split Vertical" })
keymap("n", "<leader>wh", "<cmd>split<CR>", { desc = "Split Horizontal" })
keymap("n", "<leader>wc", "<cmd>close<CR>", { desc = "Fechar Janela" })
keymap("n", "<leader>wo", "<cmd>only<CR>", { desc = "Manter Apenas Esta Janela" })
keymap("n", "<leader>w=", "<C-w>=", { desc = "Igualar Tamanho das Janelas" })
keymap("n", "<leader>wx", "<C-w>x", { desc = "Trocar Janelas de Lugar" })
keymap("n", "<leader>wm", "<cmd>MaximizeToggle<CR>", { desc = "Maximizar/Restaurar Janela" })

-- Abrir um arquivo diretamente em split:  :Vs arquivo  /  :Hs arquivo
vim.api.nvim_create_user_command("Vs", function(opts)
	vim.cmd("vsplit " .. vim.fn.fnameescape(opts.args))
end, { nargs = 1, complete = "file", desc = "Abrir arquivo em split vertical" })

vim.api.nvim_create_user_command("Hs", function(opts)
	vim.cmd("split " .. vim.fn.fnameescape(opts.args))
end, { nargs = 1, complete = "file", desc = "Abrir arquivo em split horizontal" })

-- ============================================================
-- Atalhos de conforto
-- ============================================================
keymap({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "Salvar arquivo" })
keymap("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Sair do Neovim" })
keymap("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Novo buffer vazio" })

-- Rolar a tela mantendo o cursor no meio
keymap("n", "<C-d>", "<C-d>zz", { desc = "Descer meia tela" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Subir meia tela" })

-- Colar sobre uma seleção sem perder o que estava copiado
keymap("x", "p", '"_dP', { desc = "Colar sem sobrescrever o clipboard" })
