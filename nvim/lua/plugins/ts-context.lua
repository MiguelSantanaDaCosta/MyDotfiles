return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Já presente no seu setup [cite: 55]
    opts = {
        enable = true,
        max_lines = 3,
        trim_scope = 'outer',
    }
}