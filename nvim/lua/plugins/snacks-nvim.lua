return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- 1. Dashboard (Mantenha desativado ou use como backup do Alpha)
    dashboard = { enabled = false }, 

    -- 2. Notificações (Interface moderna e rápida)
    notifier = {
      enabled = true,
      timeout = 3000,
      style = "fancy",
    },

    -- 3. Scope & Indent (Linhas de indentação estéticas)
    indent = {
      enabled = true,
      char = "│",
      scope = {
        enabled = true, -- Destaca o bloco onde o cursor está
        char = "▎",
        underline = false,
      },
      chunk = { enabled = true },
    },

    -- 4. Picker (Substitui buscas complexas do Telescope se quiser)
    picker = { enabled = true },

    -- 5. Input & Select (Janelas flutuantes arredondadas para o sistema)
    input = { enabled = true },
    select = { enabled = true },

    -- 6. Imagens (Crucial para ver docs com imagens no terminal)
    image = { enabled = true },

    -- 7. Utilitários de Performance e UI
    bigfile = { enabled = true },    -- Abre arquivos gigantes sem travar o buffer
    quickfile = { enabled = true },  -- Carregamento instantâneo
    statuscolumn = { enabled = true }, -- Margem esquerda limpa e moderna
    words = { enabled = false },      -- Grifa palavras idênticas sob o cursor
    
    -- 8. Terminal flutuante (Configurado para o seu estilo)
    terminal = {
      enabled = true,
      win = {
        style = "terminal",
        border = "rounded",
      },
    },

    -- 9. Outros módulos úteis
    scroll = { enabled = true },     -- Scroll suave (se não usar outro plugin de scroll)
    zen = { enabled = true },        -- Modo escrita limpa
    util = { enabled = true },
  },
  keys = {
    -- Atalhos recomendados para o Snacks
    { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Histórico de Notificações" },
    { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Limpar Notificações" },
    { "<leader>gb", function() Snacks.git.blame_line() end,        desc = "Git Blame Line" },
    { "<leader>lg", function() Snacks.lazygit() end,               desc = "Abrir LazyGit" },
    { "<c-/>",      function() Snacks.terminal() end,              desc = "Terminal Flutuante" },
  },
}