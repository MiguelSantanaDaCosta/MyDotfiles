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