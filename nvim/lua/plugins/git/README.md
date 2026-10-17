# git/ — Git: sinais, diff, conflitos, GitHub

> Gerado por `organizar-plugins.sh` em 17/10/2026. Resume o que cada arquivo desta pasta faz hoje; os blocos de código são cópias da configuração atual. Edite o texto à vontade.

## Índice desta pasta

| Plugin | Arquivo | Para que serve |
|---|---|---|
| [Diffview](#diffview) | `diffview.lua` | Interface para ver diffs, histórico de arquivo e resolver merges. |
| [git-conflict](#git-conflict) | `git-conflit.lua` | Destaca e ajuda a resolver conflitos de merge. |
| [Gitsigns](#gitsigns) | `gitsigns.lua` | Sinais de git na margem (linhas adicionadas, alteradas e removidas) e blame. |
| [Octo](#octo) | `octo.lua` | Trabalha com issues e pull requests do GitHub dentro do Neovim. |

## `diffview.lua`

### Diffview

- **Repositório:** https://github.com/sindrets/diffview.nvim
- **Função:** Interface para ver diffs, histórico de arquivo e resolver merges.
- **O que impacta no Neovim:** Abre painéis lado a lado com as alterações do git.
- **Carregamento:** `cmd = { "DiffviewOpen", "DiffviewFileHistory %<cr>" }` · `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-lua/plenary.nvim`
- **Exemplo de uso:** `:DiffviewOpen` mostra as mudanças atuais; `:DiffviewFileHistory %` mostra o histórico do arquivo.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>gd` | n | Git Diff View |
| `<leader>gh` | n | File History |

**Configuração atual** (`diffview.lua`):

```lua
return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory %<cr>" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git Diff View" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %", desc = "File History" },
    }
}
```

---

## `git-conflit.lua`

### git-conflict

- **Repositório:** https://github.com/akinsho/git-conflict.nvim
- **Função:** Destaca e ajuda a resolver conflitos de merge.
- **O que impacta no Neovim:** Colore os blocos de conflito e adiciona comandos para escolher um lado.
- **Carregamento:** `event = "BufReadPre"`
- **Exemplo de uso:** Em um conflito: `co` escolhe o seu lado, `ct` o do outro, `cb` ambos, `]x` e `[x` navegam entre conflitos (padrões do plugin).

**Configuração atual** (`git-conflit.lua`):

```lua
-- lua/plugins/git-conflict.lua
return {
	"akinsho/git-conflict.nvim",
	event = "BufReadPre",
	opts = {},
}
```

---

## `gitsigns.lua`

### Gitsigns

- **Repositório:** https://github.com/lewis6991/gitsigns.nvim
- **Função:** Sinais de git na margem (linhas adicionadas, alteradas e removidas) e blame.
- **O que impacta no Neovim:** Mostra o que mudou desde o último commit e permite preview/stage de hunks.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Exemplo de uso:** `:Gitsigns preview_hunk` mostra a mudança sob o cursor; `:Gitsigns blame_line` mostra o autor da linha.

**Configuração atual** (`gitsigns.lua`):

```lua
return {
    "lewis6991/gitsigns.nvim",

    config = function()
        require("gitsigns").setup({
            current_line_blame = true,
        })
    end
}
```

---

## `octo.lua`

### Octo

- **Repositório:** https://github.com/pwntester/octo.nvim
- **Função:** Trabalha com issues e pull requests do GitHub dentro do Neovim.
- **O que impacta no Neovim:** Lista, abre, comenta e revisa PRs/issues em buffers (requer o `gh` CLI autenticado).
- **Carregamento:** `cmd = "Octo"`
- **Dependências:** `nvim-lua/plenary.nvim`, `nvim-telescope/telescope.nvim`, `nvim-tree/nvim-web-devicons`
- **Exemplo de uso:** `:Octo pr list` lista as PRs do repositório.

**Configuração atual** (`octo.lua`):

```lua
-- lua/plugins/octo.lua
return {
	"pwntester/octo.nvim",
	cmd = "Octo",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {},
}
```

---

