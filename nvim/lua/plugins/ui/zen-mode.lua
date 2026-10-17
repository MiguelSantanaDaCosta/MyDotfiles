return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            width = .85, -- Largura da janela central
            options = {
                number = false,
                relativenumber = false,
            }
        },
    },
    keys = {
        { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" }
    }
}