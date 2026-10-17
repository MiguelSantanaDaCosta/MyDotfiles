return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        enable = true,
        max_lines = 3,
        trim_scope = 'outer',
        -- Desativa o context em arquivos muito grandes:
        on_attach = function(bufnr)
            local line_count = vim.api.nvim_buf_line_count(bufnr)
            if line_count > 2500 then
                return false
            end
            return true
        end,
    }
}
