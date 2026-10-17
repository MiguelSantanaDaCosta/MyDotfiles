return {
    "michaelb/sniprun",
    build = "sh ./install.sh",
    config = function()
        require("sniprun").setup({
            display = { "VirtualTextOk", "Terminal" } -- Mostra resultado ao lado do código ou no terminal
        })
        -- Atalho para rodar a linha atual ou seleção visual
        vim.keymap.set({ "n", "v" }, "<leader>rr", "<cmd>SnipRun<cr>", { desc = "Run Snippet" })
    end
}