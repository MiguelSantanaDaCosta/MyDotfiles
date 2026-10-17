return {
    "stevearc/overseer.nvim",
    opts = {
        strategy = "terminal",
        templates = { "builtin" },
    },
    config = function(_, opts)
        local overseer = require("overseer")
        overseer.setup(opts)

        -- Atalho para rodar (Run)
        vim.keymap.set("n", "<F5>", "<cmd>OverseerRun<cr>", { desc = "Run Task (NetBeans style)" })
        -- Atalho para abrir os logs/output
        vim.keymap.set("n", "<F6>", "<cmd>OverseerToggle<cr>", { desc = "Toggle Output Panel" })
    end
}