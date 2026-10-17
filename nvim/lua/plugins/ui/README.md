# ui/ — Aparência: dashboard, statusline, bufferline, notificações, scroll, guia de atalhos

> Gerado por `organizar-plugins.sh` em 17/10/2026. Resume o que cada arquivo desta pasta faz hoje; os blocos de código são cópias da configuração atual. Edite o texto à vontade.

## Índice desta pasta

| Plugin | Arquivo | Para que serve |
|---|---|---|
| [Alpha](#alpha) | `alpha.lua` | Tela inicial (dashboard) configurável, mostrada quando o Neovim abre sem arquivo. |
| [Bufferline](#bufferline) | `bufferline.lua` | Barra de abas no topo que mostra os buffers abertos. |
| [Colorizer](#colorizer) | `colorizer.lua` | Mostra a cor real de códigos como `#ff8800`, `rgb(...)`, `hsl(...)` e classes Tailwind. |
| [Dashboard (desativado)](#dashboard-desativado) | `dashboard.lua.disable` | Tela inicial alternativa ao alpha; arquivo desativado (`.disable`). |
| [Dressing](#dressing) | `dressing.lua` | Melhora as caixas de `vim.ui.select` e `vim.ui.input` (menus e prompts). |
| [Edgy](#edgy) | `edgy.lua` | Organiza painéis laterais e inferiores como em uma IDE (explorer, outline, terminal, problemas). |
| [Fidget](#fidget) | `fidget.lua` | Mostra no canto da tela o progresso do LSP e notificações discretas. |
| [Lualine](#lualine) | `lualine.lua` | Barra de status configurável. |
| [Neominimap](#neominimap) | `minimap.lua` | Minimapa lateral do arquivo, como no VS Code. |
| [Noice](#noice) | `noice.lua` | Troca a interface de linha de comando, mensagens e notificações por popups flutuantes. |
| [Rainbow Delimiters](#rainbow-delimiters) | `rainbow-delimiters.lua` | Colore parênteses, colchetes e chaves por nível de aninhamento. |
| [Neoscroll](#neoscroll) | `scroll.lua` | Rolagem suave da tela. |
| [Snacks](#snacks) | `snacks-nvim.lua` | Pacote de utilidades: terminal flutuante, notificações, guias de indentação, bufdelete e mais. |
| [tpipeline](#tpipeline) | `tpipeline.lua` | Envia a statusline do Neovim para a barra de status do tmux. |
| [Which-Key](#which-key) | `which-key.lua` | Mostra um guia dos atalhos disponíveis conforme você digita. |
| [Zen Mode](#zen-mode) | `zen-mode.lua` | Modo foco: centraliza o buffer e esconde elementos de interface. |

## `alpha.lua`

### Alpha

- **Repositório:** https://github.com/goolord/alpha-nvim
- **Função:** Tela inicial (dashboard) configurável, mostrada quando o Neovim abre sem arquivo.
- **O que impacta no Neovim:** Muda o que aparece no startup: banner animado (milli.nvim), botões de atalho e arquivos recentes.
- **Carregamento:** `lazy = false`
- **Dependências:** `amansingh-afk/milli.nvim`, `nvim-tree/nvim-web-devicons`
- **Exemplo de uso:** Abra `nvim` sem argumentos para vê-la; `:Alpha` reabre a tela depois.

**Configuração atual** (`alpha.lua`):

```lua
return {
  "goolord/alpha-nvim",
  lazy = false,
  dependencies = {
    "amansingh-afk/milli.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local milli = require("milli")

    -- 1. Carregar a animação da mariposa (moth.lua)
    local splash = milli.load({ splash = "moth" })

    -- 2. Configurar o Header com o primeiro frame
    dashboard.section.header.val = splash.frames[1]
    dashboard.section.header.opts.hl = "Normal"

    -- 3. Seus botões padrão
    dashboard.section.buttons.val = {
      dashboard.button("n", "  Novo Projeto", ":enew <CR>"),
      dashboard.button("r", "󰄉  Arquivos Recentes", ":Telescope oldfiles <CR>"),
      dashboard.button("c", "  Configurações (init.lua)", ":e $MYVIMRC <CR>"),
      dashboard.button("q", "󰅚  Sair", ":qa<CR>"),
    }

    -- 4. Estética
    dashboard.section.buttons.opts.hl = "AlphaButton"
    dashboard.opts.layout[1].val = 2 -- Espaço no topo

    alpha.setup(dashboard.opts)

    -- 5. Iniciar animação (Milli sobrepõe o header do Alpha)
    milli.alpha({ splash = "moth", loop = true })
  end,
}
```

---

## `bufferline.lua`

### Bufferline

- **Repositório:** https://github.com/akinsho/bufferline.nvim
- **Função:** Barra de abas no topo que mostra os buffers abertos.
- **O que impacta no Neovim:** Adiciona a barra superior com ícones, diagnósticos de LSP e botão de fechar, e reserva espaço ao lado do neo-tree.
- **Carregamento:** `event = "VeryLazy"` · `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-tree/nvim-web-devicons`
- **Exemplo de uso:** `:BufferLineCycleNext` / `:BufferLineCyclePrev` trocam de buffer; `:BufferLinePick` escolhe por letra.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<S-l>` | n | Próximo buffer |
| `<S-h>` | n | Buffer anterior |
| `]b` | n | Próximo buffer |
| `[b` | n | Buffer anterior |
| `<leader>bd` | n | Fechar buffer (mantém o split) |
| `<leader>bo` | n | Fechar os outros buffers |
| `<leader>bp` | n | Escolher buffer por letra |
| `<leader>bc` | n | Fechar buffer por letra |
| `<leader>bP` | n | Fixar/Desafixar buffer |

**Configuração atual** (`bufferline.lua`):

```lua
-- lua/plugins/bufferline.lua
return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			mode = "buffers",
			separator_style = "slant",
			always_show_bufferline = false,
			show_buffer_close_icons = true,
			show_close_icon = false,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count)
				return "(" .. count .. ")"
			end,
			hover = { enabled = true, delay = 150, reveal = { "close" } },
			-- Fecha o buffer sem fechar o split
			close_command = function(n)
				Snacks.bufdelete(n)
			end,
			right_mouse_command = function(n)
				Snacks.bufdelete(n)
			end,
			-- A barra não fica por cima do neo-tree
			offsets = {
				{ filetype = "neo-tree", text = "Explorador", text_align = "center", separator = true },
			},
		},
	},
	keys = {
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Próximo buffer" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer anterior" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Próximo buffer" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Buffer anterior" },
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Fechar buffer (mantém o split)" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Fechar os outros buffers" },
		{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Escolher buffer por letra" },
		{ "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Fechar buffer por letra" },
		{ "<leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "Fixar/Desafixar buffer" },
	},
}
```

---

## `colorizer.lua`

### Colorizer

- **Repositório:** https://github.com/catgoose/nvim-colorizer.lua
- **Função:** Mostra a cor real de códigos como `#ff8800`, `rgb(...)`, `hsl(...)` e classes Tailwind.
- **O que impacta no Neovim:** Pinta um marcador de cor dentro do código (virtualtext ou fundo) e é desligado nas janelas de plugins.
- **Carregamento:** `event = "BufReadPre"` · `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** Abra um CSS ou o `palette.lua`: cada cor ganha um quadradinho colorido; `:ColorizerToggle` liga/desliga.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>uc` | n | Alternar cores no código |

**Configuração atual** (`colorizer.lua`):

```lua
return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",

    keys = {
        { "<leader>uc", "<cmd>ColorizerToggle<cr>", desc = "Alternar cores no código" },
    },

    config = function()
        require("colorizer").setup({
            -- "*" = todos, "!nome" = exceto (evita pintar a interface dos plugins)
            filetypes = {
                "*",
                "!lazy",
                "!mason",
                "!neo-tree",
                "!alpha",
                "!TelescopePrompt",
                "!notify",
                "!noice",
                "!oil",
            },
            user_default_options = {
                RGB = true, -- #RGB
                RRGGBB = true, -- #RRGGBB
                RRGGBBAA = true, -- #RRGGBBAA (com transparência)
                AARRGGBB = false,
                rgb_fn = true, -- rgb() e rgba()
                hsl_fn = true, -- hsl() e hsla()
                css = true, -- liga todos os formatos CSS
                css_fn = true,
                tailwind = true, -- bg-red-500, text-sky-400...
                names = false, -- não pinta "red", "blue" em texto comum

                -- Quadradinho colorido no fim da cor, sem pintar o texto todo
                mode = "virtualtext",
                virtualtext = "■",
                virtualtext_inline = true,

                always_update = true, -- atualiza ao editar, sem precisar salvar
            },
        })
    end,
}
```

---

## `dashboard.lua.disable`  — ⏸ desativado (o lazy.nvim ignora `.disable`)

### Dashboard (desativado)

- **Repositório:** https://github.com/nvimdev/dashboard-nvim
- **Função:** Tela inicial alternativa ao alpha; arquivo desativado (`.disable`).
- **O que impacta no Neovim:** Nenhum: o lazy.nvim ignora o arquivo enquanto a extensão for `.disable`.
- **Carregamento:** `event = "VimEnter"`
- **Dependências:** `nvim-tree/nvim-web-devicons`
- **Exemplo de uso:** Para usar, renomeie para `dashboard.lua` e desative o alpha.

**Configuração atual** (`dashboard.lua.disable`):

```lua
return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        require("dashboard").setup({
            theme = "doom",
            config = {
                header = {
                    "",
                    "",
                    "",
                    "██╗   ██╗██╗███████╗████████╗   ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
                    "██║   ██║██║██╔════╝╚══██╔══╝   ████╗  ██║██║   ██║██║████╗ ████║",
                    "██║   ██║██║█████╗     ██║█████╗██╔██╗ ██║██║   ██║██║██╔████╔██║",
                    "╚██╗ ██╔╝██║██╔══╝     ██║╚════╝██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                    " ╚████╔╝ ██║███████╗   ██║      ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
                    "  ╚═══╝  ╚═╝╚══════╝   ╚═╝      ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
                    "",
                    "",
                },
                center = {
                    {
                        icon = "  ",
                        icon_hl = "Title",
                        desc = "New File               ",
                        desc_hl = "String",
                        key = "n",
                        action = ":ene"
                    },
                    {
                        icon = "  ",
                        icon_hl = "Title",
                        desc = "Find File               ",
                        desc_hl = "String",
                        key = "f",
                        action = ":Telescope find_files hidden=true no_ignore=true"
                    },
                    {
                        icon = "  ",
                        icon_hl = "Title",
                        desc = "Find Text               ",
                        desc_hl = "String",
                        key = "t",
                        action = ":Telescope live_grep"
                    },
                    {
                        icon = "  ",
                        icon_hl = "Title",
                        desc = "Update Plugins               ",
                        desc_hl = "String",
                        key = "u",
                        action = ":Lazy update"
                    },
                    {
                        icon = "󰒲  ",
                        icon_hl = "Title",
                        desc = "Lazy               ",
                        desc_hl = "String",
                        key = "l",
                        action = ":Lazy"
                    },
                    {
                        icon = "⏻  ",
                        icon_hl = "Title",
                        desc = "Quit               ",
                        desc_hl = "String",
                        key = "q",
                        action = ":qa"
                    },
                },
                footer = {
                    "",
                    " Have a great time with Viet-Nvim!!!",
                },
            }
        })
    end
}
```

---

## `dressing.lua`

### Dressing

- **Repositório:** https://github.com/stevearc/dressing.nvim
- **Função:** Melhora as caixas de `vim.ui.select` e `vim.ui.input` (menus e prompts).
- **O que impacta no Neovim:** Prompts como renomear símbolo ou escolher code action passam a aparecer como janelas flutuantes bonitas.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Exemplo de uso:** Ao rodar um `rename` do LSP ou uma code action, o prompt aparece centralizado em vez de na linha de comando.

**Configuração atual** (`dressing.lua`):

```lua
return {
    'stevearc/dressing.nvim',
    opts = {},
}
```

---

## `edgy.lua`

### Edgy

- **Repositório:** https://github.com/folke/edgy.nvim
- **Função:** Organiza painéis laterais e inferiores como em uma IDE (explorer, outline, terminal, problemas).
- **O que impacta no Neovim:** Fixa neo-tree à esquerda, aerial à direita e terminal/trouble/quickfix embaixo, com tamanhos definidos; também liga `splitkeep = 'screen'`.
- **Carregamento:** `event = "VeryLazy"`
- **Exemplo de uso:** Abra o neo-tree e o outline: eles ocupam as bordas e o código fica no centro sem os splits se desorganizarem.

**Configuração atual** (`edgy.lua`):

```lua
-- Layout de IDE: explorer à esquerda, outline à direita, terminal/trouble/quickfix embaixo
return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.splitkeep = "screen" -- recomendado pelo edgy
	end,
	opts = {
		animate = { enabled = false },
		left = {
			{ title = "Explorer", ft = "neo-tree", size = { width = 35 } },
		},
		right = {
			{ title = "Outline", ft = "aerial", size = { width = 35 } },
		},
		bottom = {
			{
				ft = "toggleterm",
				title = "Terminal",
				size = { height = 0.3 },
				filter = function(_, win)
					return vim.api.nvim_win_get_config(win).relative == ""
				end,
			},
			{ ft = "trouble", title = "Problemas", size = { height = 0.3 } },
			{ ft = "qf", title = "QuickFix", size = { height = 0.25 } },
			{
				ft = "help",
				size = { height = 20 },
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
		},
	},
}
```

---

## `fidget.lua`

### Fidget

- **Repositório:** https://github.com/j-hui/fidget.nvim
- **Função:** Mostra no canto da tela o progresso do LSP e notificações discretas.
- **O que impacta no Neovim:** Exibe mensagens como 'indexando projeto...' enquanto o servidor de linguagem trabalha.
- **Carregamento:** `event = "LspAttach"`
- **Exemplo de uso:** Abra um projeto Java: no canto inferior direito aparece o progresso do jdtls até terminar.

**Configuração atual** (`fidget.lua`):

```lua
-- lua/plugins/fidget.lua
return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		notification = { window = { winblend = 0 } },
	},
}
```

---

## `lualine.lua`

### Lualine

- **Repositório:** https://github.com/nvim-lualine/lualine.nvim
- **Função:** Barra de status configurável.
- **O que impacta no Neovim:** Substitui a statusline padrão: modo, branch, diagnósticos, nome do arquivo e breadcrumbs (nvim-navic).
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Dependências:** `nvim-tree/nvim-web-devicons`, `SmiteshP/nvim-navic`
- **Exemplo de uso:** Mude de modo (`i`, `v`) e veja a cor/indicador do modo mudar na barra inferior.

**Configuração atual** (`lualine.lua`):

```lua
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "SmiteshP/nvim-navic", -- Dependência para o breadcrumb
    },

    config = function()
        local navic = require("nvim-navic")

        require("lualine").setup({
            options = {
                theme = "auto", -- Ele vai tentar puxar as cores do Fahrenheit automaticamente
                icons_enabled = true,
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                globalstatus = true, -- Mantém uma barra única mesmo com split (melhor visual)
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                
                -- C é a seção central: onde o Navic brilha
                lualine_c = {
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { "filename", path = 1 }, -- 1 mostra o caminho relativo (útil no seu TCC/Echoes)
                    {
                        function()
                            return navic.get_location()
                        end,
                        cond = function()
                            return navic.is_available()
                        end,
                        color = { fg = "#e54b4b" }, -- Cor avermelhada para combinar com o Fahrenheit
                    },
                },
                
                lualine_x = { 
                    'encoding', 
                    'fileformat', 
                    'filetype' 
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        })
    end
}
```

---

## `minimap.lua`

### Neominimap

- **Repositório:** https://github.com/Isrothy/neominimap.nvim
- **Função:** Minimapa lateral do arquivo, como no VS Code.
- **O que impacta no Neovim:** Abre uma coluna estreita com o resumo visual do arquivo, marcando diagnósticos e alterações do git.
- **Carregamento:** `event = { "BufReadPost", "BufNewFile" }` · `cmd = { "MinimapToggle", "MinimapFocus" }` · `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** `:Neominimap toggle` liga/desliga o minimapa.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>mm` | n | Toggle Minimap |
| `<leader>mf` | n | Focus Minimap |

**Configuração atual** (`minimap.lua`):

```lua
-- lua/plugins/minimap.lua
return {
	"Isrothy/neominimap.nvim",
	cmd = { "MinimapToggle", "MinimapFocus" },
	event = { "BufReadPost", "BufNewFile" },
	init = function()
		vim.g.neominimap = {
			auto_enable = false,
			exclude_filetypes = { "help", "neo-tree", "alpha", "snacks_dashboard", "lazy" },
		}
	end,
	keys = {
		{ "<leader>mm", "<cmd>MinimapToggle<cr>", desc = "Toggle Minimap" },
		{ "<leader>mf", "<cmd>MinimapFocus<cr>", desc = "Focus Minimap" },
	},
}
```

---

## `noice.lua`

### Noice

- **Repositório:** https://github.com/folke/noice.nvim
- **Função:** Troca a interface de linha de comando, mensagens e notificações por popups flutuantes.
- **O que impacta no Neovim:** Muda a aparência de `:`, `/`, `?` e das mensagens do Neovim; usa nvim-notify para notificações.
- **Carregamento:** `event = "VeryLazy"`
- **Dependências:** `MunifTanjim/nui.nvim`, `rcarriga/nvim-notify`
- **Exemplo de uso:** Digite `:` — a linha de comando aparece em um popup no centro da tela.

**Configuração atual** (`noice.lua`):

```lua
-- lua/plugins/noice.lua
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = false, -- blink cuida disso
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true,
        },
    },
}
```

---

## `rainbow-delimiters.lua`

### Rainbow Delimiters

- **Repositório:** https://github.com/HiPhish/rainbow-delimiters.nvim
- **Função:** Colore parênteses, colchetes e chaves por nível de aninhamento.
- **O que impacta no Neovim:** Muda a cor dos delimitadores (usa treesitter), facilitando achar o par correspondente.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Exemplo de uso:** Em um código com `((( )))` aninhados, cada nível aparece em uma cor diferente.

**Configuração atual** (`rainbow-delimiters.lua`):

```lua
return {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
        local rainbow_delimiters =
            require("rainbow-delimiters")

        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = rainbow_delimiters.strategy.global,
            },
            query = {
                [''] = 'rainbow-delimiters',
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterOrange',
            },
        }
    end
}
```

---

## `scroll.lua`

### Neoscroll

- **Repositório:** https://github.com/karb94/neoscroll.nvim
- **Função:** Rolagem suave da tela.
- **O que impacta no Neovim:** Anima os comandos de rolagem (`<C-d>`, `<C-u>`, `<C-f>`, `<C-b>`, `zz`, `zt`, `zb`).
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Exemplo de uso:** Pressione `<C-d>` e veja a tela deslizar em vez de pular.

**Configuração atual** (`scroll.lua`):

```lua
return {
  "karb94/neoscroll.nvim",
  config = function()
    require('neoscroll').setup({
      -- Desativa em arquivos muito grandes para não perder performance
      hide_cursor = true,          -- Esconde o cursor durante o scroll
      stop_eof = true,             -- Para no fim do arquivo
      respect_scrolloff = false,   -- O scroll para exatamente onde você mandou
      cursor_scroll_step = 4,      -- Velocidade do scroll
      easing_function = "quadratic", -- Deixa o movimento mais "orgânico"
    })

    -- Atalhos customizados para um scroll mais suave
    local t = {}
    t['<C-u>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450'}}
    t['<C-d>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450'}}
    t['zt']    = {'zt', {'250'}}
    t['zz']    = {'zz', {'250'}}
    t['zb']    = {'zb', {'250'}}

    require('neoscroll.config').set_mappings(t)
  end
}
```

---

## `snacks-nvim.lua`

### Snacks

- **Repositório:** https://github.com/folke/snacks.nvim
- **Função:** Pacote de utilidades: terminal flutuante, notificações, guias de indentação, bufdelete e mais.
- **O que impacta no Neovim:** Cada módulo é ligado em `opts`; aqui ele cuida do terminal flutuante, das guias de indentação (`SnacksIndent`) e do fechamento de buffers sem fechar o split.
- **Carregamento:** `lazy = false` · `priority = 1000` · `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** `Snacks.bufdelete()` fecha o buffer atual mantendo a janela; os atalhos de terminal estão na tabela abaixo.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>n` | n | Histórico de Notificações |
| `<leader>un` | n | Limpar Notificações |
| `<leader>gb` | n | Git Blame Line |
| `<leader>lg` | n | Abrir LazyGit |
| `<c-/>` | n,t | Terminal Flutuante |
| `<c-_>` | n,t | Terminal Flutuante |
| `<A-t>` | n,t | Terminal Flutuante |

**Configuração atual** (`snacks-nvim.lua`):

```lua
-- Terminal flutuante (pop-up) centralizado
local function float_term()
	Snacks.terminal(nil, {
		win = {
			position = "float",
			border = "rounded",
			width = 0.85,
			height = 0.8,
		},
	})
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dashboard = { enabled = false }, -- o alpha cuida disso

		notifier = { enabled = true, timeout = 3000, style = "fancy" },

		indent = {
			enabled = true,
			char = "│",
			scope = { enabled = true, char = "▎", underline = false },
			chunk = { enabled = true },
		},

		picker = { enabled = false }, -- você usa o Telescope
		input = { enabled = true },
		select = { enabled = false }, -- telescope-ui-select já cuida

		image = { enabled = true },
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = false },

		terminal = {
			enabled = true,
			win = { style = "terminal", border = "rounded" },
		},

		scroll = { enabled = true },
		zen = { enabled = false }, -- você usa o zen-mode.nvim
		util = { enabled = true },
	},

	keys = {
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Histórico de Notificações",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Limpar Notificações",
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Abrir LazyGit",
		},
		{ "<c-/>", float_term, desc = "Terminal Flutuante", mode = { "n", "t" } },
		{ "<c-_>", float_term, desc = "Terminal Flutuante", mode = { "n", "t" } },
		{ "<A-t>", float_term, desc = "Terminal Flutuante", mode = { "n", "t" } },
	},
}
```

---

## `tpipeline.lua`

### tpipeline

- **Repositório:** https://github.com/vimpostor/vim-tpipeline
- **Função:** Envia a statusline do Neovim para a barra de status do tmux.
- **O que impacta no Neovim:** Só tem efeito dentro do tmux: a barra do tmux passa a mostrar a statusline do Neovim.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Exemplo de uso:** Dentro do tmux, a linha inferior do tmux espelha a lualine.

**Configuração atual** (`tpipeline.lua`):

```lua
return {
    "vimpostor/vim-tpipeline",
    -- Este plugin funciona melhor se você usa Tmux ou integra a barra do terminal.
}
```

---

## `which-key.lua`

### Which-Key

- **Repositório:** https://github.com/folke/which-key.nvim
- **Função:** Mostra um guia dos atalhos disponíveis conforme você digita.
- **O que impacta no Neovim:** Ao pressionar `<leader>` (ou outro prefixo) e esperar, abre um popup com as teclas seguintes e suas descrições; define os nomes dos grupos.
- **Carregamento:** `event = "VeryLazy"` · `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** Pressione `<Space>` e espere: aparecem os grupos (Find, Git, LSP...). `<leader>?` mostra os atalhos do buffer atual.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>?` | n | Atalhos do buffer atual |
| `<leader><leader>` | n | Pesquisar todos os atalhos |
| `<leader>w<space>` | n | Modo janela (hydra) |

**Configuração atual** (`which-key.lua`):

```lua
-- lua/plugins/which-key.lua
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = 200,
		expand = 1, -- grupos pequenos já aparecem expandidos na lista
		win = {
			border = "rounded",
			padding = { 1, 2 },
			title = true,
			title_pos = "center",
		},
		layout = { spacing = 4 },
		icons = { mappings = true, separator = "➜" },
		show_help = true,
		spec = {
			-- Grupos com <leader> (o which-key escolhe o ícone pelo nome)
			{ "<leader>f", group = "Buscar (Find)" },
			{ "<leader>g", group = "Git" },
			{ "<leader>l", group = "LSP / LazyGit" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>t", group = "Testes" },
			{ "<leader>b", group = "Buffers" },
			{ "<leader>j", group = "Java" },
			{ "<leader>r", group = "Rodar / Refatorar" },
			{ "<leader>w", group = "Janelas / Splits" },
			{ "<leader>c", group = "Código" },
			{ "<leader>x", group = "Diagnósticos" },
			{ "<leader>q", group = "Sessão / Sair" },
			{ "<leader>o", group = "Símbolos (Outline)" },
			{ "<leader>m", group = "Minimap" },
			{ "<leader>u", group = "UI / Undo" },
			{ "<leader>s", group = "Buscar TODOs" },
			{ "<leader>i", group = "Inlay hints" },
			{ "<leader>n", group = "Notificações / Docs" },
			{ "<leader>R", group = "REST" },

			-- Atalhos soltos (aparecem no guia com descrição)
			{ "<C-h>", desc = "Painel à esquerda", mode = "n" },
			{ "<C-j>", desc = "Painel abaixo", mode = "n" },
			{ "<C-k>", desc = "Painel acima", mode = "n" },
			{ "<C-l>", desc = "Painel à direita", mode = "n" },
			{ "<C-s>", desc = "Salvar arquivo", mode = { "n", "i", "x" } },
			{ "<C-/>", desc = "Terminal flutuante", mode = { "n", "t" } },
			{ "<A-t>", desc = "Terminal flutuante", mode = { "n", "t" } },
			{ "<C-e>", desc = "Menu do Harpoon", mode = "n" },
			{ "<A-1>", desc = "Harpoon: arquivo 1", mode = "n" },
			{ "<A-2>", desc = "Harpoon: arquivo 2", mode = "n" },
			{ "<A-3>", desc = "Harpoon: arquivo 3", mode = "n" },
			{ "<A-4>", desc = "Harpoon: arquivo 4", mode = "n" },
			{ "<S-h>", desc = "Buffer anterior", mode = "n" },
			{ "<S-l>", desc = "Próximo buffer", mode = "n" },
			{ "-", desc = "Abrir pasta atual (Oil)", mode = "n" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Atalhos do buffer atual",
		},
		{
			"<leader><leader>",
			"<cmd>Telescope keymaps<cr>",
			desc = "Pesquisar todos os atalhos",
		},
		{
			"<leader>w<space>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Modo janela (hydra)",
		},
	},
}
```

---

## `zen-mode.lua`

### Zen Mode

- **Repositório:** https://github.com/folke/zen-mode.nvim
- **Função:** Modo foco: centraliza o buffer e esconde elementos de interface.
- **O que impacta no Neovim:** Abre o arquivo atual em uma janela central, limpa e sem distrações.
- **Carregamento:** `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** `:ZenMode` liga/desliga.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>z` | n | Toggle Zen Mode |

**Configuração atual** (`zen-mode.lua`):

```lua
return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            width = .85, -- Largura da janela central
            options = {
                number = false,
                relativenumber = false,
            }
        },
    },
    keys = {
        { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" }
    }
}
```

---

