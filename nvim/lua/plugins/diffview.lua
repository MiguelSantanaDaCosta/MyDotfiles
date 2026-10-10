return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory %<cr>" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git Diff View" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %", desc = "File History" },
    }
}
