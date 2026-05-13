return {
  "karb94/neoscroll.nvim",
  config = function()
    require('neoscroll').setup({
      -- Desativa em arquivos muito grandes para não perder performance
      hide_cursor = true,          -- Esconde o cursor durante o scroll
      stop_eof = true,             -- Para no fim do arquivo
      respect_scrolloff = false,   -- O scroll para exatamente onde você mandou
      cursor_scroll_step = 4,      -- Velocidade do scroll
      easing_function = "quadratic", -- Deixa o movimento mais "orgânico"
    })

    -- Atalhos customizados para um scroll mais suave
    local t = {}
    t['<C-u>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450'}}
    t['<C-d>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450'}}
    t['zt']    = {'zt', {'250'}}
    t['zz']    = {'zz', {'250'}}
    t['zb']    = {'zb', {'250'}}

    require('neoscroll.config').set_mappings(t)
  end
}