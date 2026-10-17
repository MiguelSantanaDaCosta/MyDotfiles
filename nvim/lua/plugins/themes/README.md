# themes/ — Esquemas de cores (temas)

> Gerado por `organizar-plugins.sh` em 17/10/2026. Resume o que cada arquivo desta pasta faz hoje; os blocos de código são cópias da configuração atual. Edite o texto à vontade.

## Índice desta pasta

| Plugin | Arquivo | Para que serve |
|---|---|---|
| [Catppuccin](#catppuccin) | `catppuccin.lua` | Esquema de cores pastel com quatro variações (latte, frappé, macchiato e mocha). |
| [vim-fahrenheit (desativado)](#vim-fahrenheit-desativado) | `fahrenheit.lua.disable` | Tema Fahrenheit original como plugin externo; o arquivo está desativado (`.disable`). |
| [Miasma](#miasma) | `gen.lua` | Tema escuro em tons de musgo, terra e ferrugem. |
| [Gruvbox](#gruvbox) | `gruvbox.lua` | Esquema de cores retrô de tons quentes e terrosos (contraste suave, médio ou duro). |
| [Kanagawa](#kanagawa) | `kanagawa.lua` | Esquema de cores inspirado na pintura japonesa 'A Grande Onda', com variantes wave, dragon e lotus. |
| [Miasma](#miasma) | `miasma.lua` | Tema escuro em tons de musgo, terra e ferrugem. |
| [Rosé Pine](#ros-pine) | `themes.lua` | Tema de baixo contraste com paleta rosada e suave (variantes main, moon e dawn). |
| [Vague](#vague) | `themes.lua` | Tema minimalista e dessaturado, de baixo contraste. |
| [Nightfox](#nightfox) | `themes.lua` | Família de temas (nightfox, duskfox, nordfox, terafox, carbonfox, dayfox, dawnfox). |
| [Tokyo Night](#tokyo-night) | `themes.lua` | Tema escuro inspirado nas luzes noturnas de Tóquio (variantes moon, night, storm e day). |
| [Gruvbox Material](#gruvbox-material) | `themes.lua` | Variação do Gruvbox com contraste mais suave e cores menos saturadas. |
| [Everforest](#everforest) | `themes.lua` | Tema verde-acinzentado confortável para os olhos, inspirado em florestas. |

## `catppuccin.lua`

### Catppuccin

- **Repositório:** https://github.com/catppuccin/nvim
- **Função:** Esquema de cores pastel com quatro variações (latte, frappé, macchiato e mocha).
- **O que impacta no Neovim:** Define as cores de toda a interface e da sintaxe e já traz integração pronta com telescope, neo-tree, bufferline, etc. É o tema de reserva do seu init.lua.
- **Carregamento:** `priority = 1000`
- **Exemplo de uso:** `:colorscheme catppuccin-mocha` aplica a variação escura; `:Telescope colorscheme enable_preview=true` deixa testar todos com preview.

**Configuração atual** (`catppuccin.lua`):

```lua
return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
        require("catppuccin").setup({
            flavour = "mocha",  -- latte, frappe, macchiato, mocha
            transparent_background = true,
            float = {
                transparent = true,
            }
        })
        --vim.cmd.colorscheme("catppuccin")
    end
}
```

---

## `fahrenheit.lua.disable`  — ⏸ desativado (o lazy.nvim ignora `.disable`)

### vim-fahrenheit (desativado)

- **Repositório:** https://github.com/fcpg/vim-fahrenheit
- **Função:** Tema Fahrenheit original como plugin externo; o arquivo está desativado (`.disable`).
- **O que impacta no Neovim:** Nenhum: o lazy.nvim ignora arquivos que não terminam em `.lua`. O Fahrenheit em uso vem de `lua/fahrenheit/` e `colors/fahrenheit.lua`.
- **Carregamento:** `lazy = false` · `priority = 1000`
- **Exemplo de uso:** Para reativar, renomeie o arquivo para `fahrenheit.lua`.

**Configuração atual** (`fahrenheit.lua.disable`):

```lua
return {
	"fcpg/vim-fahrenheit",
	lazy = false,
	priority = 1000,
	config = function()
		-- 1. Carrega o tema Fahrenheit
		vim.cmd("colorscheme fahrenheit")

		-- 2. Função para aplicar transparência e negrito
		local function apply_fahrenheit_customizations()
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
			-- Baseado na paleta do tema, os comentários e palavras-chave são bons candidatos
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
				local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
				if hl then
					hl.bold = true
					vim.api.nvim_set_hl(0, group, hl)
				end
			end
		end

		-- 3. Aplica as configurações na inicialização
		apply_fahrenheit_customizations()

		-- 4. Reaplica caso você mude de tema e volte para o fahrenheit
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "fahrenheit",
			callback = apply_fahrenheit_customizations,
		})
	end,
}
```

---

## `gen.lua`

### Miasma

- **Repositório:** https://github.com/xero/miasma.nvim
- **Função:** Tema escuro em tons de musgo, terra e ferrugem.
- **O que impacta no Neovim:** Na sua config carrega ao iniciar (`lazy = false`) e executa `colorscheme miasma`, depois força fundo transparente e negrito em vários grupos.
- **Carregamento:** `lazy = false` · `priority = 1000`
- ⚠ **Declarado também em:** `themes/miasma.lua` (duplicado: o lazy.nvim mescla as duas definições)
- **Exemplo de uso:** `:colorscheme miasma`.

**Configuração atual** (`gen.lua`):

```lua
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
```

---

## `gruvbox.lua`

### Gruvbox

- **Repositório:** https://github.com/ellisonleao/gruvbox.nvim
- **Função:** Esquema de cores retrô de tons quentes e terrosos (contraste suave, médio ou duro).
- **O que impacta no Neovim:** Troca as cores da interface e da sintaxe; na sua config usa contraste hard e fundo transparente (`transparent_mode`).
- **Carregamento:** `priority = 1000`
- **Exemplo de uso:** `:colorscheme gruvbox`.

**Configuração atual** (`gruvbox.lua`):

```lua
return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = false,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			inverse = true,
			contrast = "hard", -- "", "soft" ou "hard"
			dim_inactive = false,
			transparent_mode = true, -- mesmo fundo transparente do Fahrenheit
		})
	end,
}
```

---

## `kanagawa.lua`

### Kanagawa

- **Repositório:** https://github.com/rebelot/kanagawa.nvim
- **Função:** Esquema de cores inspirado na pintura japonesa 'A Grande Onda', com variantes wave, dragon e lotus.
- **O que impacta no Neovim:** Troca as cores do editor; sua config usa a variante dragon, fundo transparente e negrito em comentários, keywords e funções.
- **Carregamento:** `lazy = true` · `priority = 1000`
- **Exemplo de uso:** `:colorscheme kanagawa-dragon`.

**Configuração atual** (`kanagawa.lua`):

```lua
return {
	"rebelot/kanagawa.nvim",
	lazy = true, -- o lazy.nvim carrega sozinho quando você roda :colorscheme kanagawa-dragon
	priority = 1000,
	opts = {
		compile = false,
		transparent = true, -- deixa o wallpaper aparecer
		dimInactive = false,
		terminalColors = true,
		theme = "dragon",
		background = { dark = "dragon", light = "lotus" },

		-- Negrito para melhorar a leitura sobre o wallpaper
		commentStyle = { italic = true, bold = true },
		keywordStyle = { italic = false, bold = true },
		statementStyle = { bold = true },
		typeStyle = { bold = true },
		functionStyle = { bold = true },

		colors = {
			theme = {
				all = { ui = { bg_gutter = "none" } }, -- números de linha/sinais sem fundo
			},
		},

		overrides = function(colors)
			local theme = colors.theme
			return {
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },
				-- menu de autocomplete continua opaco (legibilidade)
				Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
				PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar = { bg = theme.ui.bg_m1 },
				PmenuThumb = { bg = theme.ui.bg_p2 },
				TelescopeNormal = { bg = "none" },
				TelescopeBorder = { bg = "none" },
				NeoTreeNormal = { bg = "none" },
				NeoTreeNormalNC = { bg = "none" },
				StatusLine = { bg = "none" },
				StatusLineNC = { bg = "none" },
			}
		end,
	},
}
```

---

## `miasma.lua`

### Miasma

- **Repositório:** https://github.com/xero/miasma.nvim
- **Função:** Tema escuro em tons de musgo, terra e ferrugem.
- **O que impacta no Neovim:** Na sua config carrega ao iniciar (`lazy = false`) e executa `colorscheme miasma`, depois força fundo transparente e negrito em vários grupos.
- **Carregamento:** `lazy = false` · `priority = 1000`
- ⚠ **Declarado também em:** `themes/gen.lua` (duplicado: o lazy.nvim mescla as duas definições)
- **Exemplo de uso:** `:colorscheme miasma`.

**Configuração atual** (`miasma.lua`):

```lua
return {
	{
		"xero/miasma.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme miasma")
		end,
	},
}
```

---

## `themes.lua`

### Rosé Pine

- **Repositório:** https://github.com/rose-pine/neovim
- **Função:** Tema de baixo contraste com paleta rosada e suave (variantes main, moon e dawn).
- **O que impacta no Neovim:** Só carrega quando você roda `:colorscheme`; configurado com variante moon e transparência.
- **Carregamento:** `lazy = true`
- **Exemplo de uso:** `:colorscheme rose-pine-moon`.

### Vague

- **Repositório:** https://github.com/vague2k/vague.nvim
- **Função:** Tema minimalista e dessaturado, de baixo contraste.
- **O que impacta no Neovim:** Só carrega sob demanda; configurado com fundo transparente, negrito e itálico.
- **Carregamento:** `lazy = true`
- **Exemplo de uso:** `:colorscheme vague`.

### Nightfox

- **Repositório:** https://github.com/EdenEast/nightfox.nvim
- **Função:** Família de temas (nightfox, duskfox, nordfox, terafox, carbonfox, dayfox, dawnfox).
- **O que impacta no Neovim:** Só carrega sob demanda; configurado com transparência e negrito em comentários, keywords, funções e tipos.
- **Carregamento:** `lazy = true`
- **Exemplo de uso:** `:colorscheme carbonfox` ou `:colorscheme duskfox`.

### Tokyo Night

- **Repositório:** https://github.com/folke/tokyonight.nvim
- **Função:** Tema escuro inspirado nas luzes noturnas de Tóquio (variantes moon, night, storm e day).
- **O que impacta no Neovim:** Só carrega sob demanda; configurado com variante moon, transparência em sidebars e janelas flutuantes.
- **Carregamento:** `lazy = true`
- **Exemplo de uso:** `:colorscheme tokyonight-moon`.

### Gruvbox Material

- **Repositório:** https://github.com/sainnhe/gruvbox-material
- **Função:** Variação do Gruvbox com contraste mais suave e cores menos saturadas.
- **O que impacta no Neovim:** Configurado por variáveis globais (`vim.g.gruvbox_material_*`): fundo médio, transparente, negrito e itálico.
- **Carregamento:** `lazy = true`
- **Exemplo de uso:** `:colorscheme gruvbox-material`.

### Everforest

- **Repositório:** https://github.com/sainnhe/everforest
- **Função:** Tema verde-acinzentado confortável para os olhos, inspirado em florestas.
- **O que impacta no Neovim:** Configurado por variáveis globais (`vim.g.everforest_*`): fundo médio, transparente, itálico e modo de melhor performance.
- **Carregamento:** `lazy = true`
- **Exemplo de uso:** `:colorscheme everforest`.

**Configuração atual** (`themes.lua`):

```lua
-- Temas para testar (todos lazy: carregam só quando você roda :colorscheme <nome>)
-- Todos com fundo transparente e negrito onde o tema permite.
return {
	-- :colorscheme rose-pine-moon | rose-pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		opts = {
			variant = "moon",
			styles = { bold = true, italic = true, transparency = true },
		},
	},

	-- :colorscheme vague
	{
		"vague2k/vague.nvim",
		lazy = true,
		opts = { transparent = true, bold = true, italic = true },
	},

	-- :colorscheme duskfox | carbonfox | nordfox | terafox | nightfox
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		opts = {
			options = {
				transparent = true,
				styles = { comments = "italic,bold", keywords = "bold", functions = "bold", types = "bold" },
			},
		},
	},

	-- :colorscheme tokyonight-moon | tokyonight-night | tokyonight-storm
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "moon",
			transparent = true,
			styles = {
				comments = { italic = true, bold = true },
				keywords = { bold = true },
				functions = { bold = true },
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},

	-- :colorscheme gruvbox-material
	{
		"sainnhe/gruvbox-material",
		lazy = true,
		init = function()
			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_enable_italic = 1
		end,
	},

	-- :colorscheme everforest
	{
		"sainnhe/everforest",
		lazy = true,
		init = function()
			vim.g.everforest_background = "medium"
			vim.g.everforest_transparent_background = 1
			vim.g.everforest_enable_italic = 1
			vim.g.everforest_better_performance = 1
		end,
	},
}
```

---

