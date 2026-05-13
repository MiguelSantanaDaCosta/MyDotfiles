return {
    "stevearc/aerial.nvim",
    opts = {},
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("aerial").setup({
            on_attach = function(bufnr)
                -- Atalho local para pular entre símbolos
                vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
            end,
        })
        -- Atalho global para abrir o menu
        vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>", { desc = "Symbols Outline" })
    end
}