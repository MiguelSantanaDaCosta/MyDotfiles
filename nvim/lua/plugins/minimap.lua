return {
  "gorbit99/codewindow.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local codewindow = require('codewindow')
    codewindow.setup({
      active_in_terminals = false,
      auto_enable = false,
      exclude_filetypes = { 'help', 'NvimTree', 'neo-tree', 'alpha' }, -- Não abre no Alpha nem no Neo-tree
      focus_on_events = { 'WinEnter', 'CursorHold' },
    })
  end,
  keys = {
    { "<leader>mm", function() require('codewindow').toggle_minimap() end, desc = "Toggle Minimap" },
    { "<leader>mf", function() require('codewindow').toggle_focus() end, desc = "Focus Minimap" },
  },
}