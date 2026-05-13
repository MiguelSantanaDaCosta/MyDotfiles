return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTelescope", "TodoQuickFix" }, -- Carrega apenas quando usar o comando
    opts = {
        highlight = {
            keyword = "wide", -- Destaca bem a palavra (TODO, FIXME)
        },
    },
    keys = {
        { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search TODOs" },
    }
}