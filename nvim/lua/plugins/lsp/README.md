# lsp/ — LSP: servidores, mason, diagnósticos, rename, breadcrumbs, Java

> Gerado por `organizar-plugins.sh` em 17/10/2026. Resume o que cada arquivo desta pasta faz hoje; os blocos de código são cópias da configuração atual. Edite o texto à vontade.

## Índice desta pasta

| Plugin | Arquivo | Para que serve |
|---|---|---|
| [inc-rename](#inc-rename) | `inc-rename.lua` | Renomear símbolos via LSP com preview ao vivo em todo o arquivo. |
| [nvim-jdtls](#nvim-jdtls) | `jdtls.lua` | Servidor de linguagem completo para Java (Eclipse JDT.LS). |
| [lazydev](#lazydev) | `lazydev.lua` | Dá tipos e autocompletar da API do Neovim (`vim.*`) ao editar Lua. |
| [nvim-lightbulb](#nvim-lightbulb) | `lightbulb.lua` | Mostra uma lâmpada na linha quando há code action disponível. |
| [nvim-lspconfig](#nvim-lspconfig) | `lsp-config.lua` | Configuração dos servidores de linguagem (LSP). |
| [Mason](#mason) | `mason.lua` | Instalador de servidores LSP, formatadores, linters e debug adapters. |
| [nvim-navic](#nvim-navic) | `navic.lua` | Breadcrumbs do LSP: mostra em que classe/função você está. |
| [Tiny Inline Diagnostic](#tiny-inline-diagnostic) | `tiny-inline-diagnostic.lua` | Diagnósticos do LSP exibidos inline, de forma mais limpa e legível. |
| [Trouble](#trouble) | `trouble.lua` | Lista bonita de diagnósticos, referências, quickfix e TODOs. |

## `inc-rename.lua`

### inc-rename

- **Repositório:** https://github.com/smjonas/inc-rename.nvim
- **Função:** Renomear símbolos via LSP com preview ao vivo em todo o arquivo.
- **O que impacta no Neovim:** Mostra as mudanças enquanto você digita o novo nome.
- **Carregamento:** `cmd = "IncRename"` · `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** Com o cursor sobre uma variável, use o atalho de rename (tabela abaixo) e digite o novo nome.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>cR` | n | Renomear incremental |

**Configuração atual** (`inc-rename.lua`):

```lua
-- lua/plugins/inc-rename.lua
return {
	"smjonas/inc-rename.nvim",
	cmd = "IncRename",
	keys = {
		{
			"<leader>cR",
			function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			expr = true,
			desc = "Renomear incremental",
		},
	},
	opts = {},
}
```

---

## `jdtls.lua`

### nvim-jdtls

- **Repositório:** https://github.com/mfussenegger/nvim-jdtls
- **Função:** Servidor de linguagem completo para Java (Eclipse JDT.LS).
- **O que impacta no Neovim:** Ao abrir arquivos `.java` inicia o jdtls com configuração por projeto e comandos extras de Java.
- **Carregamento:** `ft = "java"`
- **Exemplo de uso:** Abra um projeto Maven/Gradle: o jdtls indexa e passa a oferecer autocompletar e refatoração.

**Configuração atual** (`jdtls.lua`):

```lua
-- lua/plugins/jdtls.lua (NOVO)
return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
        local jdtls = require("jdtls")
        local root = vim.fn.getcwd()
        local name = vim.fn.fnamemodify(root, ":t")
        local data_dir = vim.fn.stdpath("data") .. "/jdtls/" .. name

        jdtls.start_or_attach({
            cmd = { "jdtls", "-data", data_dir },
            root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
            settings = {
                java = {
                    signatureHelp = { enabled = true },
                    saveActions = { organizeImports = true },
                },
            },
        })
    end,
}
```

---

## `lazydev.lua`

### lazydev

- **Repositório:** https://github.com/folke/lazydev.nvim
- **Função:** Dá tipos e autocompletar da API do Neovim (`vim.*`) ao editar Lua.
- **O que impacta no Neovim:** Melhora o lua_ls ao editar sua própria config e plugins.
- **Carregamento:** `ft = "lua"`
- **Exemplo de uso:** Ao escrever `vim.api.` na sua config, o autocompletar lista as funções reais.

**Configuração atual** (`lazydev.lua`):

```lua
return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
```

---

## `lightbulb.lua`

### nvim-lightbulb

- **Repositório:** https://github.com/kosayoda/nvim-lightbulb
- **Função:** Mostra uma lâmpada na linha quando há code action disponível.
- **O que impacta no Neovim:** Adiciona o ícone de lâmpada na margem (carrega no `LspAttach`).
- **Carregamento:** `event = "LspAttach"`
- **Exemplo de uso:** Quando aparecer a lâmpada, use `vim.lsp.buf.code_action()` (por exemplo `<leader>ca`) para ver as ações.

**Configuração atual** (`lightbulb.lua`):

```lua
-- Lâmpada quando há code action disponível
return {
	"kosayoda/nvim-lightbulb",
	event = "LspAttach",
	opts = { autocmd = { enabled = true } },
}
```

---

## `lsp-config.lua`

### nvim-lspconfig

- **Repositório:** https://github.com/neovim/nvim-lspconfig
- **Função:** Configuração dos servidores de linguagem (LSP).
- **O que impacta no Neovim:** Liga autocompletar, ir para definição, hover, diagnósticos e code actions para cada linguagem configurada.
- **Carregamento:** `event = { "BufReadPre", "BufNewFile" }`
- **Dependências:** `williamboman/mason.nvim`, `williamboman/mason-lspconfig.nvim`, `saghen/blink.cmp`
- **Exemplo de uso:** `K` mostra a documentação, `gd` vai para a definição, `:LspInfo` mostra os servidores ativos.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<cmd>Telescope lsp_references<cr>` | gr | — |
| `<cmd>Telescope lsp_implementations<cr>` | gI | — |
| `<cmd>Telescope lsp_type_definitions<cr>` | gy | — |

**Configuração atual** (`lsp-config.lua`):

```lua
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
```

---

## `mason.lua`

### Mason

- **Repositório:** https://github.com/williamboman/mason.nvim
- **Função:** Instalador de servidores LSP, formatadores, linters e debug adapters.
- **O que impacta no Neovim:** Baixa e gerencia os binários em uma pasta própria do Neovim.
- **Carregamento:** `cmd = "Mason"`
- **Exemplo de uso:** `:Mason` abre a interface; `i` instala o pacote sob o cursor.

**Configuração atual** (`mason.lua`):

```lua
return {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    },
}
```

---

## `navic.lua`

### nvim-navic

- **Repositório:** https://github.com/SmiteshP/nvim-navic
- **Função:** Breadcrumbs do LSP: mostra em que classe/função você está.
- **O que impacta no Neovim:** Alimenta a statusline (lualine) com algo como `Classe > método`.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Dependências:** `neovim/nvim-lspconfig`
- **Exemplo de uso:** Dentro de um método Java, a barra inferior mostra `MinhaClasse > meuMetodo`.

**Configuração atual** (`navic.lua`):

```lua
return {
  "SmiteshP/nvim-navic",
  dependencies = "neovim/nvim-lspconfig",
  opts = {
    highlight = true,
    separator = " > ",
    lsp = { auto_attach = true },
  }
}
```

---

## `tiny-inline-diagnostic.lua`

### Tiny Inline Diagnostic

- **Repositório:** https://github.com/rachartier/tiny-inline-diagnostic.nvim
- **Função:** Diagnósticos do LSP exibidos inline, de forma mais limpa e legível.
- **O que impacta no Neovim:** Troca o virtual text padrão de erros/avisos por balões multilinha ao lado da linha (carrega no `LspAttach`).
- **Carregamento:** `event = "LspAttach"` · `priority = 1000`
- **Exemplo de uso:** Erre uma sintaxe: a mensagem aparece em um balão abaixo da linha com o problema.

**Configuração atual** (`tiny-inline-diagnostic.lua`):

```lua
return {
	-- Diagnósticos inline mais bonitos
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		priority = 1000,
		opts = {
			preset = "modern",
			options = { multilines = { enabled = true } },
		},
	},
}
```

---

## `trouble.lua`

### Trouble

- **Repositório:** https://github.com/folke/trouble.nvim
- **Função:** Lista bonita de diagnósticos, referências, quickfix e TODOs.
- **O que impacta no Neovim:** Abre um painel inferior com os problemas do projeto, que você navega e salta para o código.
- **Carregamento:** `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-tree/nvim-web-devicons`
- **Exemplo de uso:** `:Trouble diagnostics toggle` abre a lista de erros e avisos.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>xx` | n | Diagnostics (Trouble) |
| `<leader>xl` | n | Location List (Trouble) |

**Configuração atual** (`trouble.lua`):

```lua
return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    },
}
```

---

