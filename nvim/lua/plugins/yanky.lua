return {
    "gbprod/yanky.nvim",
    opts = {
        highlight = {
            on_put = true,
            on_yank = true,
            timer = 200,
        },
        preserve_cursor_position = {
            enabled = true,
        },
    },
    config = function(_, opts)
        require("yanky").setup(opts)
        
        -- Colar ajustando a identação automaticamente
        vim.keymap.set({"n", "x"}, "p", "<Plug>(YankPutAfterFilter)", { desc = "Colar com auto-identação" })
        vim.keymap.set({"n", "x"}, "P", "<Plug>(YankPutBeforeFilter)", { desc = "Colar antes com auto-identação" })
    end
}