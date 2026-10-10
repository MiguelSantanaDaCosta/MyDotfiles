-- ============================================================
-- init.lua — Configuração Neovim
-- ============================================================

-- ============================================================
-- 1. LEADER (antes de tudo! Plugins dependem disso)
-- ============================================================
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ============================================================
-- 2. BOOTSTRAP DO LAZY.NVIM
-- ============================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Erro ao clonar lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPressione qualquer tecla para sair..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- 3. OPÇÕES E KEYMAPS (antes dos plugins)
-- ============================================================
require("options")
require("keymaps")
require("autocmds")

-- ============================================================
-- 4. LAZY.NVIM
-- ============================================================
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},

	-- Tema usado durante a instalação inicial (fallback se falhar)
	install = { colorscheme = { "fahrenheit", "catppuccin-mocha", "habamax" } },

	-- Checagem automática de updates (silenciosa)
	checker = { enabled = true, notify = false },

	-- Não notificar mudanças em arquivos de plugin
	change_detection = { notify = false },

	ui = { border = "rounded" },

	-- Performance: carrega só o essencial no startup
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"netrwPlugin",
			},
		},
	},
})

-- ============================================================
-- 5. TEMA FAHRENHEIT (com fallback em cascata)
-- ============================================================
local themes = { "fahrenheit", "catppuccin-mocha", "habamax" }
for _, theme in ipairs(themes) do
	local ok = pcall(vim.cmd.colorscheme, theme)
	if ok then
		break
	end
end

-- ============================================================
-- 6. COMANDO :CheckPower — Diagnóstico rápido
-- ============================================================
vim.api.nvim_create_user_command("CheckPower", function()
	local lazy = require("lazy")

	local report = {
		"═══════════════ DEBUG DO SANTANA ═══════════════",
		"",
		"Neovim : " .. tostring(vim.version()),
		"Lazy   : " .. tostring(require("lazy").stats().count) .. " plugins",
		"",
	}

	-- Plugins com erro de carregamento
	local errors = {}
	for _, plugin in pairs(lazy.plugins()) do
		if plugin._ and plugin._.error then
			table.insert(errors, "❌ " .. plugin.name .. " → " .. tostring(plugin._.error))
		end
	end

	if #errors > 0 then
		table.insert(report, "── Plugins com erro ──")
		vim.list_extend(report, errors)
	else
		table.insert(report, "✅ Nenhum plugin com erro de load.")
	end

	table.insert(report, "")
	table.insert(report, "── Estatísticas ──")

	local stats = lazy.stats()
	table.insert(report, string.format("  Loaded  : %d", stats.loaded))
	table.insert(report, string.format("  Time    : %.2f ms", stats.startuptime))
	table.insert(report, string.format("  Colorscheme: %s", vim.g.colors_name or "—"))

	-- Abre em buffer flutuante
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, report)
	vim.bo[buf].modifiable = false
	vim.bo[buf].bufhidden = "wipe"

	local width = 72
	local height = math.min(#report + 2, 25)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " 🩺 Status do Sistema ",
		title_pos = "center",
	})

	-- Fecha com q ou Esc
	vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
	vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })
end, { desc = "Diagnóstico dos plugins e do ambiente" })

-- ============================================================
-- 7. ATALHOS GLOBAIS ÚTEIS
-- ============================================================

-- Abrir init.lua rapidamente
vim.keymap.set("n", "<leader>rc", "<cmd>e $MYVIMRC<cr>", { desc = "Editar init.lua" })

-- Recarregar config (útil durante desenvolvimento)
vim.keymap.set("n", "<leader>rl", function()
	-- Limpa módulos de config para forçar recarregamento
	for name in pairs(package.loaded) do
		if name:match("^options$") or name:match("^keymaps$") then
			package.loaded[name] = nil
		end
	end
	dofile(vim.env.MYVIMRC)
	vim.notify("Config recarregada!", vim.log.levels.INFO)
end, { desc = "Recarregar init.lua" })

-- ============================================================
-- 8. AUTOCMDS GLOBAIS
-- ============================================================

-- Reabrir no último local ao editar um arquivo
vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Restaurar posição do cursor",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Highlight no yank (feedback visual)
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Piscar ao copiar",
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
})

-- Criar diretórios automaticamente ao salvar
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Criar diretórios ao salvar",
	callback = function(ev)
		if ev.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(ev.match)
		if file then
			vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
		end
	end,
})

-- ============================================================
-- 9. HOT-RELOAD DO MATUGEN (File Watcher Silencioso)
-- ============================================================
-- Ativar cores hexadecimais no terminal (True Color)
vim.opt.termguicolors = true

-- Observa mudanças no arquivo gerado pelo Matugen
local palette_path = vim.fn.expand("~/.config/nvim/lua/fahrenheit/palette.lua")
local w = vim.uv.new_fs_event()

if w then
	w:start(
		palette_path,
		{},
		vim.schedule_wrap(function()
			-- 1. Limpa o módulo de cores antigo da memória
			package.loaded["fahrenheit.palette"] = nil
			package.loaded["fahrenheit.highlights"] = nil
			package.loaded["fahrenheit"] = nil

			-- 2. Recarrega as novas cores em tempo real
			pcall(vim.cmd.colorscheme, "fahrenheit")

			-- 3. Força a atualização da interface visual
			vim.cmd("redraw!")
		end)
	)
end

require("mini.icons").setup({
	-- customizar depois do setup:
})
vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = "#784943" })
vim.api.nvim_set_hl(0, "MiniIconsBlue", { fg = "#784943" })
vim.api.nvim_set_hl(0, "MiniIconsCyan", { fg = "#784943" })
vim.api.nvim_set_hl(0, "MiniIconsGreen", { fg = "#8a7a4e" })
vim.api.nvim_set_hl(0, "MiniIconsYellow", { fg = "#d4a04e" })
vim.api.nvim_set_hl(0, "MiniIconsOrange", { fg = "#d4844e" })
vim.api.nvim_set_hl(0, "MiniIconsRed", { fg = "#c25a3a" })
vim.api.nvim_set_hl(0, "MiniIconsPurple", { fg = "#a05a4e" })
vim.api.nvim_set_hl(0, "MiniIconsGrey", { fg = "#7a6f5e" })

local ok, devicons = pcall(require, "nvim-web-devicons")
if ok then
	for name, icon in pairs(devicons.get_icons()) do
		-- só aceita nomes de texto válidos para highlight group
		if type(name) == "string" and icon.icon and name:match("^[%w_%.]+$") then
			pcall(vim.api.nvim_set_hl, 0, "DevIcon" .. name, { fg = "#784943" })
		end
	end
end
