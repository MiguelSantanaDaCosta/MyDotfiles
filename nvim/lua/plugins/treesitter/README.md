# treesitter/ — Treesitter: parser, textobjects, contexto, autotag

> Gerado por `organizar-plugins.sh` em 17/10/2026. Resume o que cada arquivo desta pasta faz hoje; os blocos de código são cópias da configuração atual. Edite o texto à vontade.

## Índice desta pasta

| Plugin | Arquivo | Para que serve |
|---|---|---|
| [Treesitter Textobjects](#treesitter-textobjects) | `treesitter-textobjects.lua` | Objetos de texto baseados na sintaxe: função, classe, parâmetro, bloco. |
| [Treesitter](#treesitter) | `treesitter.lua` | Parser de sintaxe real da linguagem: base para destaque, indentação, folds e textobjects. |
| [ts-autotag](#ts-autotag) | `ts-autotag.lua` | Fecha e renomeia tags HTML/JSX/XML automaticamente. |
| [Treesitter Context](#treesitter-context) | `ts-context.lua` | Mantém no topo da janela o cabeçalho da função/classe em que você está. |

## `treesitter-textobjects.lua`

### Treesitter Textobjects

- **Repositório:** https://github.com/nvim-treesitter/nvim-treesitter-textobjects
- **Função:** Objetos de texto baseados na sintaxe: função, classe, parâmetro, bloco.
- **O que impacta no Neovim:** Permite selecionar, mover e trocar estruturas de código inteiras com atalhos.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Dependências:** `nvim-treesitter/nvim-treesitter`
- **Exemplo de uso:** Exemplo típico: `vaf` seleciona a função inteira, `dic` apaga o corpo de uma classe (os mapeamentos reais estão na tabela abaixo).

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `af` | n,x,o | — |
| `if` | n,x,o | — |
| `ac` | n,x,o | — |
| `ic` | n,x,o | — |

**Configuração atual** (`treesitter-textobjects.lua`):

```lua
-- lua/plugins/treesitter-textobjects.lua
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = { lookahead = true },
			move = { set_jumps = true },
		})

		local map = vim.keymap.set
		map({ "n", "x", "o" }, "af", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
		end)
		map({ "n", "x", "o" }, "if", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
		end)
		map({ "n", "x", "o" }, "ac", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
		end)
		map({ "n", "x", "o" }, "ic", function()
			require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
		end)
	end,
}
```

---

## `treesitter.lua`

### Treesitter

- **Repositório:** https://github.com/nvim-treesitter/nvim-treesitter
- **Função:** Parser de sintaxe real da linguagem: base para destaque, indentação, folds e textobjects.
- **O que impacta no Neovim:** Melhora o highlight, a indentação e alimenta vários plugins (aerial, ufo, rainbow-delimiters, neotest...).
- **Carregamento:** `lazy = false`
- **Exemplo de uso:** `:TSInstall python` instala o parser; `:TSUpdate` atualiza; `:InspectTree` mostra a árvore sintática.

**Configuração atual** (`treesitter.lua`):

```lua
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = { "bash", "lua", "vim", "vimdoc", "query",
                "c", "cpp", "java", "python", "javascript", "typescript",
                "html", "css", "json", "yaml", "toml", "markdown", "markdown_inline" },
        })
        -- na branch main, highlight e indent são automáticos
    end,
}
```

---

## `ts-autotag.lua`

### ts-autotag

- **Repositório:** https://github.com/windwp/nvim-ts-autotag
- **Função:** Fecha e renomeia tags HTML/JSX/XML automaticamente.
- **O que impacta no Neovim:** Ao digitar `<div>` insere `</div>`; renomear a tag de abertura renomeia a de fechamento.
- **Carregamento:** `ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "sve...`
- **Exemplo de uso:** Em um `.html`/`.tsx`, digite `<section>` e a tag de fechamento aparece.

**Configuração atual** (`ts-autotag.lua`):

```lua
-- lua/plugins/ts-autotag.lua
return {
	"windwp/nvim-ts-autotag",
	ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue" },
	opts = {},
}
```

---

## `ts-context.lua`

### Treesitter Context

- **Repositório:** https://github.com/nvim-treesitter/nvim-treesitter-context
- **Função:** Mantém no topo da janela o cabeçalho da função/classe em que você está.
- **O que impacta no Neovim:** Cria uma pequena faixa no topo mostrando o contexto quando você rola um bloco longo.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Dependências:** `nvim-treesitter/nvim-treesitter`
- **Exemplo de uso:** Rolando uma função grande, a assinatura dela fica fixa no topo.

**Configuração atual** (`ts-context.lua`):

```lua
return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        enable = true,
        max_lines = 3,
        trim_scope = 'outer',
        -- Desativa o context em arquivos muito grandes:
        on_attach = function(bufnr)
            local line_count = vim.api.nvim_buf_line_count(bufnr)
            if line_count > 2500 then
                return false
            end
            return true
        end,
    }
}
```

---

