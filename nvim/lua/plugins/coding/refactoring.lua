return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        -- Carrega apenas ao usar o atalho no modo visual (x)
        { "<leader>re", function() require('refactoring').select_refactor() end, mode = "x", desc = "Refactor" }
    },
    config = function()
        require("refactoring").setup({})
    end,
}