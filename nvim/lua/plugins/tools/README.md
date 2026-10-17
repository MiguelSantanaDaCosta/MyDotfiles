# tools/ — Ferramentas: terminal, markdown, startuptime, package.json

> Gerado por `organizar-plugins.sh` em 17/10/2026. Resume o que cada arquivo desta pasta faz hoje; os blocos de código são cópias da configuração atual. Edite o texto à vontade.

## Índice desta pasta

| Plugin | Arquivo | Para que serve |
|---|---|---|
| [Markdown Preview](#markdown-preview) | `markdown-preview.lua` | Preview de Markdown no navegador, com atualização em tempo real. |
| [package-info](#package-info) | `package-info.lua` | Mostra versões e permite atualizar dependências do `package.json`. |
| [render-markdown](#render-markdown) | `render-markdown.lua` | Renderiza Markdown dentro do próprio buffer: títulos, listas, checkboxes, tabelas e code blocks. |
| [ToggleTerm](#toggleterm) | `toggleterm.lua` | Terminais integrados ao Neovim (horizontal, vertical ou flutuante). |
| [vim-startuptime](#vim-startuptime) | `vim-startup.lua` | Mede e detalha o tempo de inicialização do Neovim. |

## `markdown-preview.lua`

### Markdown Preview

- **Repositório:** https://github.com/iamcco/markdown-preview.nvim
- **Função:** Preview de Markdown no navegador, com atualização em tempo real.
- **O que impacta no Neovim:** Abre um servidor local e atualiza a página enquanto você edita.
- **Carregamento:** `cmd = { "MarkdownPreviewToggle", "MarkdownPreview" }` · `ft = { "markdown" }`
- **Exemplo de uso:** `:MarkdownPreview` abre; `:MarkdownPreviewStop` encerra.

**Configuração atual** (`markdown-preview.lua`):

```lua
-- No seu arquivo markdown-preview.lua
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end, -- Forma mais segura de build
}
```

---

## `package-info.lua`

### package-info

- **Repositório:** https://github.com/vuki656/package-info.nvim
- **Função:** Mostra versões e permite atualizar dependências do `package.json`.
- **O que impacta no Neovim:** Adiciona virtual text com a versão mais recente de cada dependência.
- **Carregamento:** `event = "BufRead package.json"`
- **Dependências:** `MunifTanjim/nui.nvim`
- **Exemplo de uso:** Em um `package.json`: `:lua require('package-info').show()` mostra as versões disponíveis.

**Configuração atual** (`package-info.lua`):

```lua
return {
    "vuki656/package-info.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
   event = "BufRead package.json", 
    config = true,
}
```

---

## `render-markdown.lua`

### render-markdown

- **Repositório:** https://github.com/MeanderingProgrammer/render-markdown.nvim
- **Função:** Renderiza Markdown dentro do próprio buffer: títulos, listas, checkboxes, tabelas e code blocks.
- **O que impacta no Neovim:** Muda a aparência dos arquivos `.md` no Neovim (usa treesitter).
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Dependências:** `nvim-treesitter/nvim-treesitter`, `nvim-tree/nvim-web-devicons`
- **Exemplo de uso:** Abra um README: os títulos e tabelas aparecem formatados; `:RenderMarkdown toggle` alterna.

**Configuração atual** (`render-markdown.lua`):

```lua
return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
    require("render-markdown").setup({
        heading = { sign = false, icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " } },
        code = { sign = false, style = "full" },
        bullet = { icons = { "●", "○", "◆", "◇" } },
        checkbox = { enabled = true },
    })
    end
}
```

---

## `toggleterm.lua`

### ToggleTerm

- **Repositório:** https://github.com/akinsho/toggleterm.nvim
- **Função:** Terminais integrados ao Neovim (horizontal, vertical ou flutuante).
- **O que impacta no Neovim:** Abre e esconde terminais persistentes sem sair do editor.
- **Carregamento:** `cmd = { "ToggleTerm", "TermExec" }` · `keys` (carrega ao usar um dos atalhos)
- **Exemplo de uso:** `:ToggleTerm` abre/fecha o terminal; veja os atalhos na tabela abaixo.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>`` | n | Open Bottom Terminal |
| `<Esc>` | t | — |

**Configuração atual** (`toggleterm.lua`):

```lua
return {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },

    keys = {
        { "<leader>`", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Open Bottom Terminal" },
    },

    opts = { start_in_insert = false },

    init = function()
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*toggleterm#*",
            callback = function(ev)
                vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = ev.buf })
            end,
        })
    end,
}
```

---

## `vim-startup.lua`

### vim-startuptime

- **Repositório:** https://github.com/dstein64/vim-startuptime
- **Função:** Mede e detalha o tempo de inicialização do Neovim.
- **O que impacta no Neovim:** Só roda quando chamado; ajuda a achar plugins lentos.
- **Carregamento:** `cmd = "StartupTime"`
- **Exemplo de uso:** `:StartupTime` abre o relatório ordenado pelos plugins mais lentos.

**Configuração atual** (`vim-startup.lua`):

```lua
return {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
        vim.g.startuptime_tries = 10
    end,
}
```

---

