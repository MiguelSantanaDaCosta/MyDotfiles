return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
        -- Restaura a sessão do diretório atual
        { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
        -- Restaura a última sessão salva
        { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    }
}