return {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },

    keys = {
        { "<leader>`", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Open Bottom Terminal" },
    },

    opts = { start_in_insert = false },

    init = function()
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*toggleterm#*",
            callback = function(ev)
                vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = ev.buf })
            end,
        })
    end,
}
