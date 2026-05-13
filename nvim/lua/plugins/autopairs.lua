return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local autopairs = require("nvim-autopairs")
        autopairs.setup({
            check_ts = true, -- Usa Treesitter para ser mais inteligente
            ts_config = {
                lua = { "string" },
                java = { "string_literal" },
            },
        })
    end
}