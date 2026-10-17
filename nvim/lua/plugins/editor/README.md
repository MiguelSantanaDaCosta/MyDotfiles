# editor/ — Edição de texto: pares, cursores múltiplos, undo, yank, folds, mini.nvim

> Gerado por `organizar-plugins.sh` em 17/10/2026. Resume o que cada arquivo desta pasta faz hoje; os blocos de código são cópias da configuração atual. Edite o texto à vontade.

## Índice desta pasta

| Plugin | Arquivo | Para que serve |
|---|---|---|
| [nvim-ufo](#nvim-ufo) | `Ufo.lua` | Folding (dobrar código) estilo VSCode, usando treesitter ou indentação. |
| [Autopairs](#autopairs) | `autopairs.lua` | Fecha automaticamente parênteses, colchetes, chaves e aspas. |
| [Better Escape](#better-escape) | `better-escape.lua` | Permite sair do modo insert com sequências como `jk` sem atraso. |
| [gx.nvim](#gxnvim) | `gx.lua` | Abre URLs e referências sob o cursor no navegador (estende o `gx`). |
| [vim-illuminate](#vim-illuminate) | `illuminate.lua` | Destaca automaticamente as outras ocorrências da palavra sob o cursor. |
| [mini.nvim](#mininvim) | `mini-nvim.lua` | Coleção de pequenos módulos; aqui são usados surround, comment e ícones. |
| [Visual Multi](#visual-multi) | `multicursor.lua` | Cursores múltiplos. |
| [Pantran](#pantran) | `pantran.lua` | Traduz texto dentro do editor. |
| [Undotree](#undotree) | `undotree.lua` | Visualiza o histórico de desfazer como uma árvore. |
| [vim-sleuth](#vim-sleuth) | `vim-sleuth.lua` | Detecta automaticamente indentação (tab/espaços e largura) de cada arquivo. |
| [Yanky](#yanky) | `yanky.lua` | Histórico de cópias (yank ring) com preview e ciclo. |

## `Ufo.lua`

### nvim-ufo

- **Repositório:** https://github.com/kevinhwang91/nvim-ufo
- **Função:** Folding (dobrar código) estilo VSCode, usando treesitter ou indentação.
- **O que impacta no Neovim:** Todos os folds começam abertos (`foldlevel = 99`); troca o provedor de dobras padrão.
- **Carregamento:** `event = "BufReadPost"`
- **Dependências:** `kevinhwang91/promise-async`
- **Exemplo de uso:** `zR` abre todos os folds, `zM` fecha todos, `za` alterna o da posição atual.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `zR` | n | Abrir todos os folds |
| `zM` | n | Fechar todos os folds |

**Configuração atual** (`Ufo.lua`):

```lua
-- Folding estilo VSCode com treesitter/indent
return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	event = "BufReadPost",
	init = function()
		vim.o.foldcolumn = "0"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,
	config = function()
		require("ufo").setup({
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		})
		vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Abrir todos os folds" })
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Fechar todos os folds" })
	end,
}
```

---

## `autopairs.lua`

### Autopairs

- **Repositório:** https://github.com/windwp/nvim-autopairs
- **Função:** Fecha automaticamente parênteses, colchetes, chaves e aspas.
- **O que impacta no Neovim:** No modo insert, digitar `(` já insere `)` e coloca o cursor no meio.
- **Carregamento:** `event = "InsertEnter"`
- **Exemplo de uso:** Digite `foo(` e o `)` aparece sozinho.

**Configuração atual** (`autopairs.lua`):

```lua
return {

	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local autopairs = require("nvim-autopairs")
		autopairs.setup({
			check_ts = true, -- Usa Treesitter para ser mais inteligente
			ts_config = {
				lua = { "string" },
				java = { "string_literal" },
			},
		})
	end,
}
```

---

## `better-escape.lua`

### Better Escape

- **Repositório:** https://github.com/max397574/better-escape.nvim
- **Função:** Permite sair do modo insert com sequências como `jk` sem atraso.
- **O que impacta no Neovim:** Cria mapeamentos de insert que equivalem a `<Esc>`.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Exemplo de uso:** No modo insert, digite `jk` rapidamente para voltar ao normal.

**Configuração atual** (`better-escape.lua`):

```lua
return {
    "max397574/better-escape.nvim",
    config = function()
        require("better_escape").setup()
    end,
}
```

---

## `gx.lua`

### gx.nvim

- **Repositório:** https://github.com/chrishrb/gx.nvim
- **Função:** Abre URLs e referências sob o cursor no navegador (estende o `gx`).
- **O que impacta no Neovim:** Faz o `gx` entender links markdown, URLs e outros padrões.
- **Carregamento:** `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-lua/plenary.nvim`
- **Exemplo de uso:** Com o cursor sobre `https://...` pressione `gx`.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `gx` | n,x | — |

**Configuração atual** (`gx.lua`):

```lua
return {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
}
```

---

## `illuminate.lua`

### vim-illuminate

- **Repositório:** https://github.com/RRethy/vim-illuminate
- **Função:** Destaca automaticamente as outras ocorrências da palavra sob o cursor.
- **O que impacta no Neovim:** Usa LSP/treesitter para marcar usos da mesma variável; navegação entre usos pelos atalhos configurados.
- **Carregamento:** `event = { "BufReadPost", "BufNewFile" }`
- **Exemplo de uso:** Pare o cursor sobre uma variável e veja todos os usos dela iluminados.

**Configuração atual** (`illuminate.lua`):

```lua
-- lua/plugins/illuminate.lua
return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("illuminate").configure({
			delay = 200,
			large_file_cutoff = 2000,
			filetypes_denylist = { "neo-tree", "alpha", "lazy", "TelescopePrompt" },
		})
	end,
}
```

---

## `mini-nvim.lua`

### mini.nvim

- **Repositório:** https://github.com/nvim-mini/mini.nvim
- **Função:** Coleção de pequenos módulos; aqui são usados surround, comment e ícones.
- **O que impacta no Neovim:** Adiciona edição de delimitadores (`sa`, `sd`, `sr`), comentar (`gc`/`gcc`) e ícones para vários plugins.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Exemplo de uso:** `<leader>/` comenta a linha; `saiw"` envolve a palavra com aspas.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>/` | n | Toggle Comment (Normal mode) |
| `<leader>/` | v | Toggle Comment (Visual mode) |

**Configuração atual** (`mini-nvim.lua`):

```lua
return {
    "nvim-mini/mini.nvim",

    config = function()
        -- Auto pairs
        --local pairs = require("mini.pairs")
        --pairs.setup({})

        -- Surround
        local surround = require("mini.surround")
        surround.setup({})

        -- Comment code
        local comment = require("mini.comment")
        comment.setup({
            ignore_blank_line = true,
        })
        vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle Comment (Normal mode)" })    -- Space /
        vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle Comment (Visual mode)" })     -- Space /
    end
}
```

---

## `multicursor.lua`

### Visual Multi

- **Repositório:** https://github.com/mg979/vim-visual-multi
- **Função:** Cursores múltiplos.
- **O que impacta no Neovim:** Permite editar várias ocorrências ao mesmo tempo.
- **Carregamento:** `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** `<C-n>` sobre uma palavra seleciona a próxima ocorrência; digite para editar todas.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<C-n>` | n,x | Multicursor |

**Configuração atual** (`multicursor.lua`):

```lua
return {
    "mg979/vim-visual-multi",
    keys = {
        { "<C-n>", mode = { "n", "x" }, desc = "Multicursor" },
    },
    -- Remova a linha: event = "BufReadPost"
}
```

---

## `pantran.lua`

### Pantran

- **Repositório:** https://github.com/potamides/pantran.nvim
- **Função:** Traduz texto dentro do editor.
- **O que impacta no Neovim:** Abre uma janela de tradução e pode substituir a seleção pelo texto traduzido.
- **Carregamento:** `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** Selecione um texto e rode `:Pantran`.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>rt` | n,x | Traduzir texto |

**Configuração atual** (`pantran.lua`):

```lua
return {
    "potamides/pantran.nvim",
    opts = {},
    keys = {
        { "<leader>rt", "<cmd>Pantran<cr>", mode = { "n", "x" }, desc = "Traduzir texto" },
    },
}
```

---

## `undotree.lua`

### Undotree

- **Repositório:** https://github.com/mbbill/undotree
- **Função:** Visualiza o histórico de desfazer como uma árvore.
- **O que impacta no Neovim:** Permite voltar a qualquer estado anterior do arquivo, inclusive de ramificações.
- **Carregamento:** `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** `:UndotreeToggle` abre a árvore; navegue e pressione `<CR>` para voltar àquele estado.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>u` | n | Visualizar Árvore de Undo |

**Configuração atual** (`undotree.lua`):

```lua
return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", vim.cmd.UndotreeToggle, desc = "Visualizar Árvore de Undo" }
  }
}
```

---

## `vim-sleuth.lua`

### vim-sleuth

- **Repositório:** https://github.com/tpope/vim-sleuth
- **Função:** Detecta automaticamente indentação (tab/espaços e largura) de cada arquivo.
- **O que impacta no Neovim:** Ajusta `shiftwidth`/`expandtab` ao abrir o arquivo, respeitando o estilo existente.
- **Carregamento:** `lazy = false`
- **Exemplo de uso:** Abra um arquivo que usa 2 espaços: o Neovim já passa a indentar com 2 espaços.

**Configuração atual** (`vim-sleuth.lua`):

```lua
return {
	-- Detecta indentação (tab/espaços) de cada arquivo
	{ "tpope/vim-sleuth", lazy = false },
}
```

---

## `yanky.lua`

### Yanky

- **Repositório:** https://github.com/gbprod/yanky.nvim
- **Função:** Histórico de cópias (yank ring) com preview e ciclo.
- **O que impacta no Neovim:** Guarda o que você copiou e deixa escolher de novo; destaca o texto colado/copiado.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Exemplo de uso:** `<leader>y` abre o histórico; escolha uma entrada para colar.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `p` | n,x | Paste indented |
| `P` | n,x | Paste before indented |
| `<leader>y` | n | Yank History |

**Configuração atual** (`yanky.lua`):

```lua
return {
    "gbprod/yanky.nvim",
    opts = {
        highlight = {
            on_put = true,
            on_yank = true,
            timer = 200,
        },
        preserve_cursor_position = {
            enabled = true,
        },
    },
  config = function(_, opts)
    require("yanky").setup(opts)
    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankPutAfterFilter)", { desc = "Paste indented" })
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankPutBeforeFilter)", { desc = "Paste before indented" })
    -- histórico de yank
    vim.keymap.set("n", "<leader>y", "<cmd>YankyRingHistory<cr>", { desc = "Yank History" })
end 
}
```

---

