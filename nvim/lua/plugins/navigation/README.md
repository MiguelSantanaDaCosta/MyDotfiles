# navigation/ — Busca e navegação: arquivos, buffers, projetos, símbolos, saltos, TODOs, sessões

> Gerado por `organizar-plugins.sh` em 17/10/2026. Resume o que cada arquivo desta pasta faz hoje; os blocos de código são cópias da configuração atual. Edite o texto à vontade.

## Índice desta pasta

| Plugin | Arquivo | Para que serve |
|---|---|---|
| [Aerial](#aerial) | `aerial.lua` | Outline (índice de símbolos) do arquivo: funções, classes, métodos. |
| [Flash](#flash) | `flash.lua` | Saltos rápidos pelo texto usando rótulos de letras. |
| [goto-preview](#goto-preview) | `goto-preview.lua` | Abre definição, implementação ou referências em janela flutuante, sem sair do arquivo. |
| [Harpoon](#harpoon) | `harpoon.lua` | Marca poucos arquivos principais e alterna entre eles instantaneamente. |
| [Neo-tree](#neo-tree) | `neo-tree.lua` | Explorador de arquivos em árvore, com git status e ícones. |
| [nvim-bqf](#nvim-bqf) | `nvim-bqf.lua` | Melhora a janela de quickfix com preview do trecho selecionado. |
| [Oil](#oil) | `oil.lua` | Edita o sistema de arquivos como se fosse um buffer de texto. |
| [Persistence](#persistence) | `persistence.lua` | Salva e restaura sessões (buffers e janelas abertas) por diretório. |
| [project.nvim](#projectnvim) | `project.lua` | Detecta a raiz do projeto (.git, package.json...) e mantém o diretório de trabalho nela. |
| [Spectre](#spectre) | `spectre.lua` | Buscar e substituir no projeto inteiro, com preview das mudanças. |
| [Telescope](#telescope) | `telescope.lua` | Buscador fuzzy para arquivos, texto, buffers, atalhos, temas e muito mais. |
| [Todo Comments](#todo-comments) | `todo-comments.lua` | Destaca e lista comentários TODO, FIXME, NOTE, HACK etc. |

## `aerial.lua`

### Aerial

- **Repositório:** https://github.com/stevearc/aerial.nvim
- **Função:** Outline (índice de símbolos) do arquivo: funções, classes, métodos.
- **O que impacta no Neovim:** Abre uma janela lateral com a estrutura do arquivo e permite pular para cada símbolo.
- **Carregamento:** `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-treesitter/nvim-treesitter`, `nvim-tree/nvim-web-devicons`
- **Exemplo de uso:** `:AerialToggle` abre o outline; navegue com `j`/`k` e `<CR>` salta para o símbolo.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>o` | n | Symbols Outline |
| `<leader>on` | n | Next Symbol |
| `<leader>op` | n | Prev Symbol |

**Configuração atual** (`aerial.lua`):

```lua
-- lua/plugins/aerial.lua
return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
		layout = { min_width = 28 },
		show_guides = true,
		filter_kind = false,
		guides = { mid_item = "├╴", last_item = "└╴" },
	},
	keys = {
		{ "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Symbols Outline" },
		{ "<leader>on", "<cmd>AerialNext<CR>", desc = "Next Symbol" },
		{ "<leader>op", "<cmd>AerialPrev<CR>", desc = "Prev Symbol" },
	},
}
```

---

## `flash.lua`

### Flash

- **Repositório:** https://github.com/folke/flash.nvim
- **Função:** Saltos rápidos pelo texto usando rótulos de letras.
- **O que impacta no Neovim:** Muda a navegação: com o atalho configurado você digita 1-2 letras e salta direto para qualquer ocorrência visível.
- **Carregamento:** `event = "VeryLazy"` · `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** Acione o flash (veja o atalho abaixo), digite `fu` e pressione a letra mostrada sobre o destino.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `s` | n,x,o | Flash |
| `S` | n,x,o | Flash Treesitter |
| `r` | o | Remote Flash |
| `R` | o,x | Treesitter Search |
| `<c-s>` | c | Toggle Flash Search |

**Configuração atual** (`flash.lua`):

```lua
return{
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
```

---

## `goto-preview.lua`

### goto-preview

- **Repositório:** https://github.com/rmagatti/goto-preview
- **Função:** Abre definição, implementação ou referências em janela flutuante, sem sair do arquivo.
- **O que impacta no Neovim:** Adiciona janelas de preview do LSP; fechar o preview devolve você ao mesmo ponto.
- **Carregamento:** `event = "LspAttach"`
- **Exemplo de uso:** Com o cursor sobre uma função, use o atalho de preview de definição (tabela abaixo) para espiar o código.

**Configuração atual** (`goto-preview.lua`):

```lua
-- lua/plugins/goto-preview.lua
return {
	"rmagatti/goto-preview",
	event = "LspAttach",
	config = function()
		require("goto-preview").setup({
			width = 120,
			height = 20,
			border = { "rounded" },
			default_mappings = true,
		})
	end,
}
```

---

## `harpoon.lua`

### Harpoon

- **Repositório:** https://github.com/ThePrimeagen/harpoon
- **Função:** Marca poucos arquivos principais e alterna entre eles instantaneamente.
- **O que impacta no Neovim:** Mantém uma lista curta por projeto; trocar de arquivo vira um atalho de uma tecla.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Dependências:** `nvim-lua/plenary.nvim`
- **Exemplo de uso:** Marque o arquivo atual e use `<A-1>`...`<A-4>` para pular entre os marcados (veja tabela abaixo).

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>a` | n | Harpoon Mark File |
| `<C-e>` | n | — |
| `<A-1>` | n | — |
| `<A-2>` | n | — |
| `<A-3>` | n | — |
| `<A-4>` | n | — |

**Configuração atual** (`harpoon.lua`):

```lua
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }, 
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon Mark File" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        -- Atalhos rápidos para os primeiros 4 arquivos
        vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
    end
}
```

---

## `neo-tree.lua`

### Neo-tree

- **Repositório:** https://github.com/nvim-neo-tree/neo-tree.nvim
- **Função:** Explorador de arquivos em árvore, com git status e ícones.
- **O que impacta no Neovim:** Abre a barra lateral de arquivos (fica à esquerda); aceita criar, renomear, mover e apagar.
- **Carregamento:** `cmd = "Neotree"` · `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-lua/plenary.nvim`, `nvim-tree/nvim-web-devicons`, `MunifTanjim/nui.nvim`
- **Exemplo de uso:** `<leader>e` abre/fecha; dentro dele `h`/`l` fecham/abrem pasta e `<BS>` sobe um nível.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>e` | n | Explorador de arquivos |
| `<leader>E` | n | Explorador flutuante |

**Configuração atual** (`neo-tree.lua`):

```lua
return {
    "nvim-neo-tree/neo-tree.nvim",

    branch = "v3.x",

    cmd = "Neotree",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    keys = {
        {
            "<leader>e",
            function()
                require("neo-tree.command").execute({
                    toggle = true,
                    reveal = true,
                    dir = vim.uv.cwd(),
                })
            end,
            desc = "Explorador de arquivos",
        },
        { "<leader>E", "<cmd>Neotree float reveal<cr>", desc = "Explorador flutuante" },
    },

    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            sort_case_insensitive = true,

            default_component_configs = {
                indent = {
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    with_expanders = true,
                },
                git_status = {
                    symbols = {
                        added = "+",
                        modified = "~",
                        deleted = "✖",
                        renamed = "➜",
                        untracked = "?",
                        ignored = "◌",
                        unstaged = "○",
                        staged = "●",
                        conflict = "!",
                    },
                },
            },

            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
            },

            window = {
                position = "left",
                width = 32,
                mappings = {
                    -- Navegação estilo Vim
                    ["h"] = "close_node", -- fecha a pasta aberta
                    ["l"] = "open", -- abre pasta/arquivo
                    ["<bs>"] = "navigate_up", -- sobe um nível (pasta anterior)
                    ["-"] = "navigate_up", -- idem
                    ["."] = "set_root", -- entra na pasta como nova raiz
                    ["H"] = "toggle_hidden",

                    -- Abrir em split
                    ["s"] = "open_vsplit",
                    ["S"] = "open_split",
                    ["P"] = { "toggle_preview", config = { use_float = true } },

                    -- Libera o <Space> para o <leader> funcionar dentro do tree
                    ["<space>"] = "none",
                },
            },
        })
    end,
}
```

---

## `nvim-bqf.lua`

### nvim-bqf

- **Repositório:** https://github.com/kevinhwang91/nvim-bqf
- **Função:** Melhora a janela de quickfix com preview do trecho selecionado.
- **O que impacta no Neovim:** Só carrega em buffers `qf`; mostra preview flutuante e filtro fuzzy na lista.
- **Carregamento:** `ft = "qf"`
- **Exemplo de uso:** Rode `:grep TODO` ou `:copen`: ao mover pela lista aparece o preview do código.

**Configuração atual** (`nvim-bqf.lua`):

```lua
return {
	-- Quickfix com preview
	{ "kevinhwang91/nvim-bqf", ft = "qf" },
}
```

---

## `oil.lua`

### Oil

- **Repositório:** https://github.com/stevearc/oil.nvim
- **Função:** Edita o sistema de arquivos como se fosse um buffer de texto.
- **O que impacta no Neovim:** Renomear, mover e apagar arquivos vira editar linhas e salvar com `:w`; carrega no início (`lazy = false`).
- **Carregamento:** `lazy = false` · `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-tree/nvim-web-devicons`
- **Exemplo de uso:** `-` abre a pasta do arquivo atual; edite um nome e `:w` confirma a mudança; `<leader>-` abre em janela flutuante.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `-` | n | Abrir pasta atual (Oil) |
| `<leader>-` | n | Oil flutuante |

**Configuração atual** (`oil.lua`):

```lua
return {
	-- Editar o sistema de arquivos como um buffer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Abrir pasta atual (Oil)" },
			{ "<leader>-", "<cmd>Oil --float<cr>", desc = "Oil flutuante" },
		},
		opts = {
			default_file_explorer = false, -- o neo-tree continua abrindo diretórios
			columns = { "icon" },
			view_options = { show_hidden = true },
			float = { padding = 4, border = "rounded" },
			keymaps = {
				["<C-h>"] = false, -- mantém a navegação entre painéis
				["<C-l>"] = false,
				["<C-s>"] = false, -- mantém o salvar
				["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Abrir em split vertical" },
				["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Abrir em split horizontal" },
				["q"] = "actions.close",
			},
		},
	},
}
```

---

## `persistence.lua`

### Persistence

- **Repositório:** https://github.com/folke/persistence.nvim
- **Função:** Salva e restaura sessões (buffers e janelas abertas) por diretório.
- **O que impacta no Neovim:** Grava a sessão automaticamente ao sair; você restaura quando quiser.
- **Carregamento:** `event = "BufReadPre"` · `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** `<leader>qs` restaura a sessão do diretório atual; `<leader>ql` a última sessão.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>qs` | n | Restore Session |
| `<leader>ql` | n | Restore Last Session |

**Configuração atual** (`persistence.lua`):

```lua
return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
        -- Restaura a sessão do diretório atual
        { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
        -- Restaura a última sessão salva
        { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    }
}
```

---

## `project.lua`

### project.nvim

- **Repositório:** https://github.com/ahmedkhalf/project.nvim
- **Função:** Detecta a raiz do projeto (.git, package.json...) e mantém o diretório de trabalho nela.
- **O que impacta no Neovim:** Muda o `cwd` ao abrir arquivos e adiciona a lista de projetos recentes ao Telescope.
- **Carregamento:** `event = "VeryLazy"` · `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-telescope/telescope.nvim`
- **Exemplo de uso:** `:Telescope projects` lista os projetos recentes e abre o escolhido.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>fp` | n | Find Projects |

**Configuração atual** (`project.lua`):

```lua
return {
    "ahmedkhalf/project.nvim",

    event = "VeryLazy",

    dependencies = {
        "nvim-telescope/telescope.nvim",
    },

    config = function()
        require("project_nvim").setup({
            detection_methods = {
                "pattern",
                "lsp",
            },

            patterns = {
                ".git",
                "pom.xml",
                "package.json",
                "Cargo.toml",
                "Makefile",
            },

            silent_chdir = true,
        })

        pcall(function()
            require("telescope")
                .load_extension("projects")
        end)
    end,

    keys = {
        {
            "<leader>fp",
            "<cmd>Telescope projects<cr>",
            desc = "Find Projects",
        },
    },
}
```

---

## `spectre.lua`

### Spectre

- **Repositório:** https://github.com/nvim-pack/nvim-spectre
- **Função:** Buscar e substituir no projeto inteiro, com preview das mudanças.
- **O que impacta no Neovim:** Abre um painel de busca/substituição em vários arquivos; você confere linha a linha antes de aplicar.
- **Carregamento:** `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-lua/plenary.nvim`
- **Exemplo de uso:** `:Spectre`, digite o termo e o substituto e aplique as trocas escolhidas.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>S` | n | Busca e Substituição Global |

**Configuração atual** (`spectre.lua`):

```lua
return {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>S", function() require("spectre").toggle() end, desc = "Busca e Substituição Global" },
    },
}
```

---

## `telescope.lua`

### Telescope

- **Repositório:** https://github.com/nvim-telescope/telescope.nvim
- **Função:** Buscador fuzzy para arquivos, texto, buffers, atalhos, temas e muito mais.
- **O que impacta no Neovim:** Abre janelas de busca flutuantes; é a base de vários atalhos `<leader>f`.
- **Carregamento:** `cmd = "Telescope"` · `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-lua/plenary.nvim`, `nvim-telescope/telescope-ui-select.nvim`, `nvim-telescope/telescope-fzf-native.nvim`, `ahmedkhalf/project.nvim`
- **Exemplo de uso:** `<leader>ff` busca arquivos, `<leader>fg` busca texto no projeto, `<leader>fb` lista buffers.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>ff` | n | Find Files |
| `<leader>fc` | n | Trocar tema (com preview) |
| `<leader>fg` | n | Live Grep |
| `<leader>fb` | n | Buffers |
| `<leader>fr` | n | Recent Files |
| `<leader>fw` | n | Grep Palavra sob o Cursor |
| `<leader>fh` | n | Help Tags |
| `<leader>fk` | n | Buscar Atalhos |
| `<leader>fd` | n | Diagnósticos |
| `<leader>fs` | n | Símbolos do Arquivo |
| `<leader>fS` | n | Símbolos do Projeto |
| `<leader>f/` | n | Buscar no Arquivo Atual |
| `<leader>f.` | n | Retomar Última Busca |
| `<leader>gc` | n | Git Commits |
| `<leader>gs` | n | Git Status |

**Configuração atual** (`telescope.lua`):

```lua
return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"ahmedkhalf/project.nvim", -- necessário para a extensão "projects"
	},

	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fc", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Trocar tema (com preview)" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep Palavra sob o Cursor" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Buscar Atalhos" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnósticos" },
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Símbolos do Arquivo" },
		{ "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Símbolos do Projeto" },
		{ "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buscar no Arquivo Atual" },
		{ "<leader>f.", "<cmd>Telescope resume<cr>", desc = "Retomar Última Busca" },
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_config = { prompt_position = "top" },
				file_ignore_patterns = { "node_modules/", "%.git/", "target/", "build/", "%.class$" },
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob",
					"!**/.git/*",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					},
				},
			},

			pickers = {
				find_files = { hidden = true },
			},

			extensions = {
				["ui-select"] = require("telescope.themes").get_dropdown({}),

				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
		telescope.load_extension("projects")
	end,
}
```

---

## `todo-comments.lua`

### Todo Comments

- **Repositório:** https://github.com/folke/todo-comments.nvim
- **Função:** Destaca e lista comentários TODO, FIXME, NOTE, HACK etc.
- **O que impacta no Neovim:** Colore essas palavras nos comentários e permite listar todas do projeto.
- **Carregamento:** `cmd = { "TodoTelescope", "TodoQuickFix" }` · `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-lua/plenary.nvim`
- **Exemplo de uso:** Escreva `-- TODO: ajustar` e rode `:TodoTelescope` para listar todos os TODOs.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>st` | n | Search TODOs |

**Configuração atual** (`todo-comments.lua`):

```lua
return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTelescope", "TodoQuickFix" }, -- Carrega apenas quando usar o comando
    opts = {
        highlight = {
            keyword = "wide", -- Destaca bem a palavra (TODO, FIXME)
        },
    },
    keys = {
        { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search TODOs" },
    }
}
```

---

