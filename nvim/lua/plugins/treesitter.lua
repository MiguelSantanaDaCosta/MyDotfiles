return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = { "bash", "lua", "vim", "vimdoc", "query",
                "c", "cpp", "java", "python", "javascript", "typescript",
                "html", "css", "json", "yaml", "toml", "markdown", "markdown_inline" },
        })
        -- na branch main, highlight e indent são automáticos
    end,
}
