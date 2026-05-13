return {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>S", function() require("spectre").toggle() end, desc = "Busca e Substituição Global" },
    },
}