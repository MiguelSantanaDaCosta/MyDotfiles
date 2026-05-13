return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "rcasia/neotest-java",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
        }),
        require("neotest-java"),
      },
    })
  end,
  keys = {
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Rodar Teste" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Painel de Testes" },
  },
}