-- 1. BOOTSTRAP DO LAZY.NVIM (Essencial para instalar o gerenciador)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Erro ao clonar lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPressione qualquer tecla para sair..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 2. IMPORTAÇÃO DAS OPÇÕES E KEYMAPS (Devem carregar ANTES dos plugins)
require("options")
require("keymaps")

-- 3. CONFIGURAÇÃO DO LAZY.NVIM
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- Carrega tudo em lua/plugins/ (Alpha, Neo-tree, etc)
    
    -- Dependências essenciais para Java/LSP que vi no seu log anterior
    { "mfussenegger/nvim-jdtls" },
    { "theHamsta/nvim-dap-virtual-text" },
  },
  checker = { enabled = true, notify = false },
  ui = { border = "rounded" },
})

-- 4. TEMA FAHRENHEIT (Configuração robusta)
-- O pcall evita que o Neovim quebre se o tema falhar ao carregar
local status_f, fahrenheit = pcall(require, "fahrenheit")
if status_f then
    fahrenheit.setup()
    vim.cmd("colorscheme fahrenheit")
    
    -- Garante que os highlights do Fahrenheit sejam aplicados corretamente
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        local p_status, palette = pcall(require, "fahrenheit.palette")
        if p_status then
            require("fahrenheit.highlights").setup(palette.colors)
        end
      end,
    })
else
    vim.notify("Aviso: Tema Fahrenheit não encontrado. Usando tema padrão.", vim.log.levels.WARN)
end

-- 5. AUTOCMDS PARA O ALPHA (Garante que ele abra no início)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.line2byte(vim.fn.line("$")) == -1 then
      local status_a, alpha = pcall(require, "alpha")
      if status_a then
        alpha.start(false)
      end
    end
  end,
})

-- 6. COMANDO CHECKPOWER (Versão corrigida e simplificada)
vim.api.nvim_create_user_command("CheckPower", function()
    local lazy = require("lazy")
    local report = { "=== DEBUG DO SANTANA ===", "" }
    
    for _, plugin in pairs(lazy.plugins()) do
        if plugin._.error then
            table.insert(report, "❌ ERRO: " .. plugin.name)
            table.insert(report, "   └─> " .. tostring(plugin._.error))
        end
    end
    
    if #report == 2 then table.insert(report, "✅ Tudo rodando liso!") end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, report)
    vim.api.nvim_open_win(buf, true, {
        relative = 'editor', width = 70, height = 15,
        col = 5, row = 5, border = 'rounded', title = " Status do Sistema "
    })
end, {})


-- Adicione isso para sobrescrever o azul do Snacks
local set_hl = vim.api.nvim_set_hl

-- SnacksWords: Palavras iguais à que está sob o cursor
-- bg = "#2a2a2a" é um cinza bem escuro que simula a transparência no fundo preto
set_hl(0, "SnacksWords", { bg = "#2a2a2a", fg = "none" })

-- SnacksWordsCurrent: A palavra exatamente onde o cursor está agora
set_hl(0, "SnacksWordsCurrent", { bg = "#333333", fg = "none", bold = true })-- Isso vai deixar o destaque com um fundo cinza escuro/alaranjado, sutil