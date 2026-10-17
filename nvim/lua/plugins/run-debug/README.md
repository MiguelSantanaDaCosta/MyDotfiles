# run-debug/ — Executar, depurar e testar: dap, neotest, overseer, REST, banco de dados

> Gerado por `organizar-plugins.sh` em 17/10/2026. Resume o que cada arquivo desta pasta faz hoje; os blocos de código são cópias da configuração atual. Edite o texto à vontade.

## Índice desta pasta

| Plugin | Arquivo | Para que serve |
|---|---|---|
| [dap virtual text](#dap-virtual-text) | `dap-virtual-text.lua` | Mostra o valor das variáveis ao lado do código durante a depuração. |
| [nvim-dap](#nvim-dap) | `dap.lua` | Cliente do Debug Adapter Protocol: breakpoints, step, inspeção de variáveis (com dap-ui). |
| [Dadbod UI](#dadbod-ui) | `database.lua` | Cliente de banco de dados dentro do Neovim (com autocompletar SQL). |
| [Neotest](#neotest) | `neotest.lua` | Executa e acompanha testes (Java e Python aqui) com resultado no editor. |
| [Overseer](#overseer) | `overseer.lua` | Gerenciador de tarefas (build, run, scripts) com painel de saída. |
| [rest.nvim](#restnvim) | `rest.lua` | Cliente HTTP: executa requisições escritas em arquivos `.http`. |
| [SnipRun](#sniprun) | `sniprun.lua` | Executa trechos de código e mostra o resultado no editor. |

## `dap-virtual-text.lua`

### dap virtual text

- **Repositório:** https://github.com/theHamsta/nvim-dap-virtual-text
- **Função:** Mostra o valor das variáveis ao lado do código durante a depuração.
- **O que impacta no Neovim:** Só tem efeito com uma sessão de debug ativa.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Dependências:** `mfussenegger/nvim-dap`
- **Exemplo de uso:** Durante o debug, cada variável exibe seu valor atual no fim da linha.

**Configuração atual** (`dap-virtual-text.lua`):

```lua
-- lua/plugins/dap-virtual-text.lua
return {
	"theHamsta/nvim-dap-virtual-text",
	dependencies = { "mfussenegger/nvim-dap" },
	opts = {},
}
```

---

## `dap.lua`

### nvim-dap

- **Repositório:** https://github.com/mfussenegger/nvim-dap
- **Função:** Cliente do Debug Adapter Protocol: breakpoints, step, inspeção de variáveis (com dap-ui).
- **O que impacta no Neovim:** Adiciona depuração dentro do editor, com painéis de variáveis, pilha e console.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Dependências:** `rcarriga/nvim-dap-ui`, `nvim-neotest/nvim-nio`
- **Exemplo de uso:** `:lua require('dap').toggle_breakpoint()` marca breakpoint; `:lua require('dap').continue()` inicia/continua.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<F9>` | n | — |
| `<F10>` | n | — |

**Configuração atual** (`dap.lua`):

```lua
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        
        vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
        vim.keymap.set("n", "<F10>", dap.continue)
    end
}
```

---

## `database.lua`

### Dadbod UI

- **Repositório:** https://github.com/kristijanhusak/vim-dadbod-ui
- **Função:** Cliente de banco de dados dentro do Neovim (com autocompletar SQL).
- **O que impacta no Neovim:** Abre um painel de conexões e permite rodar consultas SQL em buffers.
- **Carregamento:** `cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer", }`
- **Dependências:** `tpope/vim-dadbod`, `kristijanhusak/vim-dadbod-completion`
- **Exemplo de uso:** `:DBUI` abre a interface; `:DBUIAddConnection` cadastra uma conexão.

**Configuração atual** (`database.lua`):

```lua
return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
    end,
}
```

---

## `neotest.lua`

### Neotest

- **Repositório:** https://github.com/nvim-neotest/neotest
- **Função:** Executa e acompanha testes (Java e Python aqui) com resultado no editor.
- **O que impacta no Neovim:** Mostra status de cada teste na margem e abre painel de saída.
- **Carregamento:** `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-neotest/nvim-nio`, `nvim-lua/plenary.nvim`, `nvim-treesitter/nvim-treesitter`, `nvim-neotest/neotest-python`, `rcasia/neotest-java`, `mfussenegger/nvim-jdtls`
- **Exemplo de uso:** `:lua require('neotest').run.run()` roda o teste sob o cursor; `...run.run(vim.fn.expand('%'))` roda o arquivo.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>tr` | n | Run Test |
| `<leader>ts` | n | Test Summary |

**Configuração atual** (`neotest.lua`):

```lua
return {
    "nvim-neotest/neotest",

    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",

        "nvim-neotest/neotest-python",

        "rcasia/neotest-java",

        -- necessário para Java
        "mfussenegger/nvim-jdtls",
    },

    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = {
                        justMyCode = false,
                    },
                }),

                require("neotest-java")({
                    ignore_wrapper = false,
                }),
            },
        })
    end,

    keys = {
        {
            "<leader>tr",
            function()
                require("neotest").run.run()
            end,
            desc = "Run Test",
        },

        {
            "<leader>ts",
            function()
                require("neotest").summary.toggle()
            end,
            desc = "Test Summary",
        },
    },
}
```

---

## `overseer.lua`

### Overseer

- **Repositório:** https://github.com/stevearc/overseer.nvim
- **Função:** Gerenciador de tarefas (build, run, scripts) com painel de saída.
- **O que impacta no Neovim:** Detecta tarefas do projeto e permite rodá-las e acompanhá-las dentro do editor.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Exemplo de uso:** `:OverseerRun` lista as tarefas disponíveis; `:OverseerToggle` abre o painel.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<F5>` | n | Run Task (NetBeans style) |
| `<F6>` | n | Toggle Output Panel |

**Configuração atual** (`overseer.lua`):

```lua
return {
    "stevearc/overseer.nvim",
    opts = {
        strategy = "terminal",
        templates = { "builtin" },
    },
    config = function(_, opts)
        local overseer = require("overseer")
        overseer.setup(opts)

        -- Atalho para rodar (Run)
        vim.keymap.set("n", "<F5>", "<cmd>OverseerRun<cr>", { desc = "Run Task (NetBeans style)" })
        -- Atalho para abrir os logs/output
        vim.keymap.set("n", "<F6>", "<cmd>OverseerToggle<cr>", { desc = "Toggle Output Panel" })
    end
}
```

---

## `rest.lua`

### rest.nvim

- **Repositório:** https://github.com/rest-nvim/rest.nvim
- **Função:** Cliente HTTP: executa requisições escritas em arquivos `.http`.
- **O que impacta no Neovim:** Permite testar APIs sem sair do Neovim e ver a resposta em um buffer.
- **Carregamento:** `ft = "http"` · `keys` (carrega ao usar um dos atalhos)
- **Dependências:** `nvim-lua/plenary.nvim`
- **Exemplo de uso:** Em um `.http` com `GET https://api.exemplo.com/users`, rode `:Rest run`.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>Rr` | n | Rodar requisição HTTP |

**Configuração atual** (`rest.lua`):

```lua
-- lua/plugins/rest.lua
return {
	"rest-nvim/rest.nvim",
	ft = "http",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>Rr", "<cmd>Rest run<cr>", desc = "Rodar requisição HTTP" },
	},
	opts = {},
}
```

---

## `sniprun.lua`

### SnipRun

- **Repositório:** https://github.com/michaelb/sniprun
- **Função:** Executa trechos de código e mostra o resultado no editor.
- **O que impacta no Neovim:** Roda a linha ou seleção no interpretador da linguagem e exibe a saída.
- **Carregamento:** ao iniciar o Neovim (sem gatilho de carregamento preguiçoso)
- **Exemplo de uso:** Selecione algumas linhas de Python e rode `:SnipRun`.

**Atalhos configurados neste arquivo**

| Atalho | Modo | O que faz |
|---|---|---|
| `<leader>rr` | n,v | Run Snippet |

**Configuração atual** (`sniprun.lua`):

```lua
return {
    "michaelb/sniprun",
    build = "sh ./install.sh",
    config = function()
        require("sniprun").setup({
            display = { "VirtualTextOk", "Terminal" } -- Mostra resultado ao lado do código ou no terminal
        })
        -- Atalho para rodar a linha atual ou seleção visual
        vim.keymap.set({ "n", "v" }, "<leader>rr", "<cmd>SnipRun<cr>", { desc = "Run Snippet" })
    end
}
```

---

