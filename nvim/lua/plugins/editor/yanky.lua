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
    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankPutAfterFilter)", { desc = "Paste indented" })
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankPutBeforeFilter)", { desc = "Paste before indented" })
    -- histórico de yank
    vim.keymap.set("n", "<leader>y", "<cmd>YankyRingHistory<cr>", { desc = "Yank History" })
end 
}
