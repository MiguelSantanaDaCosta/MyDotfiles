# coding/ — Escrever código: completar, formatar, lint, refatorar, documentar

> Gerado por `organizar-plugins.sh` em 17/10/2026. Resume o que cada arquivo desta pasta faz hoje; os blocos de código são cópias da configuração atual. Edite o texto à vontade.

## Índice desta pasta

| Plugin | Arquivo | Para que serve |
|---|---|---|
| [blink.cmp](#blinkcmp) | `autocomplete.lua` | Motor de autocompletar rápido (LSP, snippets, caminhos, buffer). |
| [Mason Tool Installer](#mason-tool-installer) | `formatting.lua` | Garante que uma lista de ferramentas esteja sempre instalada pelo Mason. |
| [Conform](#conform) | `formatting.lua` | Formatador de código com vários formatadores por linguagem. |
| [nvim-lint](#nvim-lint) | `lint.lua` | Linters assíncronos que complementam o LSP. |
| [Neogen](#neogen) | `neogen.lua` | Gera comentários de documentação (docstrings, Javadoc, JSDoc). |
| [Refactoring](#refactoring) | `refactoring.lua` | Refatorações automáticas: extrair função, extrair variável, inline. |

## `autocomplete.lua`

### blink.cmp

- **Repositório:** https://github.com/saghen/blink.cmp
- **Função:** Motor de autocompletar rápido (LSP, snippets, caminhos, buffer).
- **O que impacta no Neovim:** Abre o menu de sugestões enquanto você digita; usa o preset de teclas `super-tab` e os snippets do friendly-snippets.
- **Carregamento:** `event = { "InsertEnter", "CmdlineEnter" }`
- **Dependências:** `rafamadriz/friendly-snippets`
- **Exemplo de uso:** Digite parte de um nome e o menu aparece; `<Tab>` aceita/avança, `<C-Space>` abre o menu manualmente.

**Configuração atual** (`autocomplete.lua`):

```lua
return {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },

    opts = {
        keymap = { preset = "super-tab" },
        appearance = { nerd_font_variant = "mono" },

        completion = {
            menu = { border = "rounded" },
            ghost_text = { enabled = true },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = { border = "rounded" },
            },
        },

        signature = { enabled = true, window = { border = "rounded" } },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            per_filetype = {
                lua = { inherit_defaults = true, "lazydev" },
            },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },

    opts_extend = { "sources.default" },
}
```

---

## `formatting.lua`

### Mason Tool Installer

- **Repositório:** https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
- **Função:** Garante que uma lista de ferramentas esteja sempre instalada pelo Mason.
- **O que impacta no Neovim:** Instala automaticamente stylua, clang-format, black e prettier (definidos em `ensure_installed`).
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Exemplo de uso:** Em uma máquina nova, abra o nvim e ele instala sozinho os formatadores listados.

### Conform

- **Repositório:** https://github.com/stevearc/conform.nvim
- **Função:** Formatador de código com vários formatadores por linguagem.
- **O que impacta no Neovim:** Formata o arquivo (e, se configurado, ao salvar) usando as ferramentas instaladas pelo Mason.
- **Carregamento:** `event = { "BufReadPre", "BufNewFile" }`
- **Exemplo de uso:** `:ConformInfo` mostra os formatadores ativos; o atalho de formatar está na tabela abaixo.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>gf` | n,v | Format Code |

**Configuração atual** (`formatting.lua`):

```lua
-- lua/plugins/formatting.lua
return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = { "stylua", "clang-format", "black", "prettier" },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    c = { "clang_format" },      -- nome do formatter interno
                    cpp = { "clang_format" },
                    python = { "black" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    html = { "prettier" },
                    css = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                },
                format_on_save = {
                    timeout_ms = 1000,
                    lsp_format = "fallback",
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>gf", function()
                conform.format({ async = true, lsp_format = "fallback" })
            end, { desc = "Format Code" })
        end,
    },
}
```

---

## `lint.lua`

### nvim-lint

- **Repositório:** https://github.com/mfussenegger/nvim-lint
- **Função:** Linters assíncronos que complementam o LSP.
- **O que impacta no Neovim:** Roda os linters configurados e mostra os problemas como diagnósticos.
- **Carregamento:** `event = { "BufReadPre", "BufNewFile" }`
- **Exemplo de uso:** Salve um arquivo Python: o linter configurado marca problemas de estilo no código.

**Configuração atual** (`lint.lua`):

```lua
-- lua/plugins/lint.lua
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint" },
			typescript = { "eslint" },
			javascriptreact = { "eslint" },
			typescriptreact = { "eslint" },
			python = { "ruff" },
			lua = { "luacheck" },
			sh = { "shellcheck" },
			markdown = { "markdownlint" },
			yaml = { "yamllint" },
			dockerfile = { "hadolint" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
```

---

## `neogen.lua`

### Neogen

- **Repositório:** https://github.com/danymat/neogen
- **Função:** Gera comentários de documentação (docstrings, Javadoc, JSDoc).
- **O que impacta no Neovim:** Cria o esqueleto de documentação da função/classe sob o cursor, com campos para preencher.
- **Carregamento:** `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-treesitter/nvim-treesitter`
- **Exemplo de uso:** Cursor sobre uma função e `:Neogen`.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>nf` | n | Gerar Docstring (Função/Classe) |

**Configuração atual** (`neogen.lua`):

```lua
return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    keys = {
        { "<leader>nf", function() require('neogen').generate() end, desc = "Gerar Docstring (Função/Classe)" }
    }
}
```

---

## `refactoring.lua`

### Refactoring

- **Repositório:** https://github.com/ThePrimeagen/refactoring.nvim
- **Função:** Refatorações automáticas: extrair função, extrair variável, inline.
- **O que impacta no Neovim:** Adiciona operações de refatoração sobre a seleção visual.
- **Carregamento:** `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-lua/plenary.nvim`, `nvim-treesitter/nvim-treesitter`
- **Exemplo de uso:** Selecione um bloco e escolha 'Extract Function' no menu de refatoração (veja atalhos abaixo).

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>re` | x | Refactor |

**Configuração atual** (`refactoring.lua`):

```lua
return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        -- Carrega apenas ao usar o atalho no modo visual (x)
        { "<leader>re", function() require('refactoring').select_refactor() end, mode = "x", desc = "Refactor" }
    },
    config = function()
        require("refactoring").setup({})
    end,
}
```

---

